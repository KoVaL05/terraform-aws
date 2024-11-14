resource "aws_s3_bucket" "cloud_trail_bucket" {
  bucket = format("cloud-trail-bucket-%s", var.random_name)
  force_destroy = true
}

resource "aws_s3_bucket_policy" "example" {
  bucket = aws_s3_bucket.cloud_trail_bucket
  policy = data.aws_iam_policy_document.cloud_trail_policy.json
}