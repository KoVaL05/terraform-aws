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
      "eventName" : ["RotateSecret", "UpdateSecret", "PutSecretValue"]
      "responseElements": {
            "arn": [format("arn:aws:secretsmanager:%s:%s:secret:*",data.aws_region.current.name,data.aws_caller_identity.current.account_id)]
        }
    }
  })
}

resource "aws_cloudwatch_event_target" "secrets_manager_sns_target" {
  rule = aws_cloudwatch_event_rule.secrets_manager_event_rule.name
  arn  = aws_sns_topic.secrets_manager_topic.arn
}
