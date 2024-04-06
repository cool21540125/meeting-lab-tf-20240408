
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "tf_s3_backend_bucket" {
  bucket = var.backend_bucket

  tags = {
    Usage = "job meeting lab"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning
resource "aws_s3_bucket_versioning" "tf_s3_backend_bucket_versioning" {
  bucket = aws_s3_bucket.tf_s3_backend_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}