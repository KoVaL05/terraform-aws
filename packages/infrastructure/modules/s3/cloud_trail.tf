resource "aws_cloudtrail" "default_cloud_trail" {
  name = "event_manager"
  s3_bucket_name = aws_s3_bucket.cloud_trail_bucket.id
}