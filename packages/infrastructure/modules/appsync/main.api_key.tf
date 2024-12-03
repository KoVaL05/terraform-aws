resource "aws_appsync_graphql_api" "api_key_public" {
  name = "API Key Public"
  authentication_type = "AMAZON_COGNITO_USER_POOLS"

  user_pool_config {
    aws_region = data.aws_region.current.name
    user_pool_id = var.user_pool_id
    default_action = "DENY"
  }

  schema = data.local_file.api_key_schema.content
  query_depth_limit = 2
  introspection_config = "DISABLED"
}