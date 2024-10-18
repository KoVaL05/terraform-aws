resource "aws_cognito_identity_provider" "google_provider" {
  user_pool_id  = aws_cognito_user_pool.default_user_pool.id
  provider_name = "Google"
  provider_type = "Google"

  provider_details = {
    authorize_scopes = "email profile"
    client_id        = var.gcp_web_client_id
    client_secret    = var.gcp_web_client_secret
  }
  attribute_mapping = {
    email       = "email"
    username    = "sub"
    name        = "name"
    family_name = "family_name"
  }
}
