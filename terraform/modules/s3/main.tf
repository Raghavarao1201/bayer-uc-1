resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "audio_bucket" {
  bucket        = "sales-agent-audio-${random_id.suffix.hex}"
  force_destroy = true

  tags = {
    Project     = "sales-agent"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.audio_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.audio_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.audio_bucket.id

  rule {
    id     = "auto-expire-after-30-days"
    status = "Enabled"

    filter {

    }

    expiration {
      days = 30
    }
  }
}
