data "aws_iam_policy_document" "secret_manager_sns_policy" {
  statement {
    sid = "SecretPublishSns"
    actions = [
      "sns:Publish",
    ]
    principals {
      identifiers = ["events.amazonaws.com"]
      type        = "Service"
    }
    effect = "Allow"
    resources = [
      var.secret_manager_sns_arn,

    ]
  }
}