resource "aws_cognito_user_pool" "default_user_pool" {
  name = "default"

  auto_verified_attributes = ["email"]
  alias_attributes         = ["email", "preferred_username"]
  deletion_protection      = "ACTIVE"

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "admin_only"
      priority = 1
    }
  }

  //TODO lambda_config
}

resource "aws_cognito_user_pool_client" "default_client" {
  name            = "client"
  user_pool_id    = aws_cognito_user_pool.default_user_pool.id
  generate_secret = true

  # allowed_oauth_flows_user_pool_client = true
  # callback_urls                        = ["https://example.com"]
  # allowed_oauth_flows                  = ["implicit"]
  # allowed_oauth_scopes                 = ["profile", "email", "openid"]

  explicit_auth_flows = ["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_CUSTOM_AUTH", "ALLOW_USER_SRP_AUTH","ALLOW_USER_PASSWORD_AUTH"]

  supported_identity_providers = [aws_cognito_identity_provider.google_provider.provider_name]
  access_token_validity        = 10
  id_token_validity            = 10
  refresh_token_validity       = 5

  default_redirect_uri = "aethera://"
  logout_urls = ["aethera://"]

  read_attributes  = ["nickname", "profile", "picture", "name"]
  write_attributes = ["nickname", "profile", "picture"]
  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }
}