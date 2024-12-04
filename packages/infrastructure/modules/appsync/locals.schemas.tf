data "local_file" "api_key_schema" {
    filename = format("%s/graph/api_key.gql",path.module)
}