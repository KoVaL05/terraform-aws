resource "aws_sns_topic_policy" "sns_topic_policy" {
  arn    = aws_sns_topic.secrets_manager_topic.arn
  policy = data.aws_iam_policy_document.secret_manager_sns_policy.json
}