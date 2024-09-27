resource "aws_cognito_user_pool_domain" "default_domain" {
  domain       = format("test-%s", var.random_name)
  user_pool_id = aws_cognito_user_pool.default_user_pool.id
}