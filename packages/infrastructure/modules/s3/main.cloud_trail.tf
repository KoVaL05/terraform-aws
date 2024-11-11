resource "aws_s3_bucket" "cloud_trail_bucket" {
  bucket = format("cloud-trail-bucket-%s", var.random_name)
}