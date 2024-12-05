resource "aws_appsync_resolver" "get-api-key" {
  type        = "Query"
  api_id      = aws_appsync_graphql_api.api_key_public.id
  data_source = aws_appsync_datasource.api_key_table.name
  field       = "getApiKey"
  kind        = "UNIT"
  code        = file(format("%s/../resolvers/get_api_key.js",path.root))


  runtime {
    name            = "APPSYNC_JS"
    runtime_version = "1.0.0"
  }
}
