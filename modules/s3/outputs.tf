output "bucket_arn" {
  value = aws_s3_bucket.s3_bucket.arn
}

output "lifecycle_rules" {
  value = var.lifecycle_rules
}
