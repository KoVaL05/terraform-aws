data "local_file" "api_key_schema" {
  filename = format("%s/graphql/api_key.gql", path.module)
}