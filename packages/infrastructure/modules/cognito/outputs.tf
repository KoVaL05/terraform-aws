output "user_pool_id" {
  value = aws_cognito_user_pool_client.default_client.id
}

output "client_pool_id" {
  value = aws_cognito_user_pool.default_user_pool.id
}