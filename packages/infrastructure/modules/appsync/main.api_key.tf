resource "aws_appsync_graphql_api" "api_key_public" {
  name                = "API_Key_Public"
  authentication_type = "AMAZON_COGNITO_USER_POOLS"

  user_pool_config {
    aws_region     = data.aws_region.current.name
    user_pool_id   = var.user_pool_id

    default_action = "ALLOW"
  }

  schema               = data.local_file.api_key_schema.content
  query_depth_limit    = 2
  introspection_config = "DISABLED"
}

resource "aws_appsync_datasource" "api_key_table" {
  name = "api_key_table"
  type = "AMAZON_DYNAMODB"

  api_id           = aws_appsync_graphql_api.api_key_public.id
  service_role_arn = aws_iam_role.appsync_api_key_role.arn

  dynamodb_config {
    table_name = var.api_key_table_name
  }
}