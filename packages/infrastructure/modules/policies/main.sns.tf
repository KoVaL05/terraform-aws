resource "aws_sns_topic_policy" "sns_topic_policy" {
  arn    = var.secret_manager_sns_arn
  policy = data.aws_iam_policy_document.secret_manager_sns_policy.json
}