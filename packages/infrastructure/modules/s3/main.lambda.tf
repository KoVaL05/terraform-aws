resource "aws_s3_bucket" "lambdas_bucket" {
  bucket = format("lambdas_bucket_%s", var.random_name)
}

resource "aws_s3_bucket_public_access_block" "lambdas_bucket_public_access" {
  bucket = aws_s3_bucket.lambdas_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "lambdas_bucket_ownership" {
  bucket = aws_s3_bucket.lambdas_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "lambdas_bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.lambdas_bucket_ownership,
    aws_s3_bucket_public_access_block.lambdas_bucket_public_access
  ]

  bucket = aws_s3_bucket.lambdas_bucket.id
  acl    = "private"
}
