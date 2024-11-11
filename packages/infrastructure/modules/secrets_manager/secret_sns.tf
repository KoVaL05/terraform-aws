resource "aws_sns_topic" "secret_manager_topic" {
  name = "SecretsChangeTopic"
}

resource "aws_cloudwatch_event_rule" "secrets_manager_event_rule" {
  name        = "SecretManagerEventRule"
  description = "Triggers on Secrets Manager events like rotation or update"
  event_pattern = jsonencode({
    "source": ["aws.secretsmanager"],
    "detail-type": ["AWS API Call via CloudTrail"],
    "detail": {
      "eventName": ["RotateSecret", "UpdateSecret","PutSecretValue"]
    }
  })
}

resource "aws_sns_topic_policy" "sns_topic_policy" {
  arn    = aws_sns_topic.secret_manager_topic.arn
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": { "Service": "events.amazonaws.com" },
        "Action": "sns:Publish",
        "Resource": aws_sns_topic.secrets_manager_topic.arn
      }
    ]
  })
}

resource "aws_cloudwatch_event_target" "secrets_manager_sns_target" {
  rule      = aws_cloudwatch_event_rule.secrets_manager_event_rule.name
  arn       = aws_sns_topic.secrets_manager_topic.arn
}

resource "aws_lambda_permission" "allow_eventbridge_to_sns" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "sns:Publish"
  function_name = aws_sns_topic.secrets_manager_topic.arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.secrets_manager_event_rule.arn
}