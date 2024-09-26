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
