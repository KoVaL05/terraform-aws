output "user_pool_arn" {
  value = aws_cognito_user_pool_client.default_client.user_pool_id
}
output "user_pool_id" {
  value = aws_cognito_user_pool.default_user_pool.id
}
