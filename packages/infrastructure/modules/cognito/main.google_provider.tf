# resource "aws_cognito_identity_provider" "example_provider" {
#   user_pool_id  = aws_cognito_user_pool.default_user_pool.id
#   provider_name = "Google"
#   provider_type = "Google"

#   provider_details = {
#     authorize_scopes = "email"
#     client_id        = "your client_id"
#     client_secret    = "your client_secret"
#   }

#   attribute_mapping = {
#     email    = "email"
#     username = "sub"
#   }
# }
