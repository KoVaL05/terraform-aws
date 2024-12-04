resource "aws_cloudtrail" "sm_cloud_trail" {
  name = "sm_event_manager"
  s3_bucket_name = aws_s3_bucket.cloud_trail_bucket.id
  enable_logging = true
  include_global_service_events = false

  advanced_event_selector {
    name = "SecretsManagerSelector"

    field_selector {
      field  = "eventSource"
      equals = ["secretsmanager.amazonaws.com"]
    }
  }
}