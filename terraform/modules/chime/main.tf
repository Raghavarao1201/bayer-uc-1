resource "random_id" "chime_suffix" {
  byte_length = 4
}

# S3 bucket to store Chime media/logs (optional)
resource "aws_s3_bucket" "chime_sma_logs" {
  bucket        = "chime-sma-logs-${random_id.chime_suffix.hex}"
  force_destroy = true

  tags = {
    Name        = "chime-sma-logs"
    Environment = var.environment
  }
}

# IAM Role for Lambda (SMA handler)
resource "aws_iam_role" "sma_lambda_role" {
  name = "smaLambdaExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# IAM Policy for Lambda to access Transcribe, Polly, Logs
resource "aws_iam_policy" "sma_lambda_policy" {
  name = "smaLambdaPolicy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:*",
          "transcribe:StartStreamTranscriptionWebSocket",
          "polly:SynthesizeSpeech",
          "s3:PutObject"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_sma_policy" {
  role       = aws_iam_role.sma_lambda_role.name
  policy_arn = aws_iam_policy.sma_lambda_policy.arn
}

# Lambda Function for SIP Media Application (to be attached manually)
resource "aws_lambda_function" "sma_handler" {
  filename         = data.archive_file.sma_lambda_zip.output_path
  function_name    = "SMAHandler"
  role             = aws_iam_role.sma_lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.11"
  timeout          = 15
  memory_size      = 256
  source_code_hash = data.archive_file.sma_lambda_zip.output_base64sha256

  environment {
    variables = {
      ECS_ENDPOINT = var.ecs_endpoint
    }
  }
}

data "archive_file" "sma_lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda_sma_code"
  output_path = "${path.module}/lambda_sma_payload.zip"
}

# Chime Voice Connector (can be linked manually to SMA)
resource "aws_chime_voice_connector" "voice_connector" {
  name               = "SalesAgentVoiceConnector"
  require_encryption = false
  aws_region         = var.aws_region
}

resource "aws_chime_voice_connector_logging" "vc_logging" {
  voice_connector_id       = aws_chime_voice_connector.voice_connector.id
  enable_sip_logs          = true
  enable_media_metric_logs = true
}

resource "aws_chime_voice_connector_streaming" "vc_streaming" {
  voice_connector_id             = aws_chime_voice_connector.voice_connector.id
  data_retention                 = 1
  disabled                       = false
  streaming_notification_targets = ["EventBridge"]
}