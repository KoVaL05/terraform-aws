data "aws_iam_policy_document" "lambdas_bucket_access_policy" {
  statement {
    sid = "S3LambdasAccess"
    actions = [
      "s3:DeleteObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]
    effect = "Allow"
    resources = [
      var.lambdas_bucket_arn,
      format("%s/*", var.lambdas_bucket_arn)
    ]
  }
} //WRITE POLICY FOR ACCESSING S3 bucket
