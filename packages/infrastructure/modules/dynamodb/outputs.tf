output "api_key_table_name" {
  value = aws_dynamodb_table.api_key_table.name
}

output "api_key_table_arn" {
  value = aws_dynamodb_table.api_key_table.arn
}