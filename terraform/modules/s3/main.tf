resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "audio_bucket" {
  bucket = "sales-agent-audio-${random_id.suffix.hex}"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    enabled = true
    expiration {
      days = 30
    }
  }

  tags = {
    Project     = "sales-agent"
    Environment = var.environment
  }
}
