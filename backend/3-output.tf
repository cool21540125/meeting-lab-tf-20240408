output "out_bucket_name" {
  value = aws_s3_bucket.tf_s3_backend_bucket.id
}

output "out_bucket_region" {
  value = aws_s3_bucket.tf_s3_backend_bucket.region
}

output "out_bucket_arn" {
  value = aws_s3_bucket.tf_s3_backend_bucket.arn
}