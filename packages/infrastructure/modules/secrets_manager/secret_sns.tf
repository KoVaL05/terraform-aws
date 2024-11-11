resource "aws_sns_topic" "secrets_manager_topic" {
  name = "SecretsChangeTopic"
}

resource "aws_cloudwatch_event_rule" "secrets_manager_event_rule" {
  name        = "SecretManagerEventRule"
  description = "Triggers on Secrets Manager events like rotation or update"
  event_pattern = jsonencode({
    "source" : ["aws.secretsmanager"],
    "detail-type" : ["AWS API Call via CloudTrail"],
    "detail" : {
      "eventName" : ["RotateSecret", "UpdateSecret", "PutSecretValue", "DeleteSecret"]
    }
  })
}

resource "aws_cloudwatch_event_target" "secrets_manager_sns_target" {
  rule = aws_cloudwatch_event_rule.secrets_manager_event_rule.name
  arn  = aws_sns_topic.secrets_manager_topic.arn
}
