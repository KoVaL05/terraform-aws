output "appsync_role_id" {
  value = aws_iam_role.appsync_api_key_role.id
}

output "api_key_appsync_arn" {
  value = aws_appsync_graphql_api.api_key_public.arn
}