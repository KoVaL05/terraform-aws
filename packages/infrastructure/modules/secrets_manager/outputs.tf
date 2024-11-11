output "secret_manager_sns_arn" {
  value = aws_sns_topic.secrets_manager_topic.arn
}