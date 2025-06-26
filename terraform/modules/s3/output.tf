output "bucket_name" {
  description = "The name of the audio S3 bucket"
  value       = aws_s3_bucket.audio_bucket.bucket
}
