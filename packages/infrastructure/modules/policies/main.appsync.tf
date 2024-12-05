resource "aws_iam_role_policy" "appsync_iam_policy" {
  name   = "appsync_iam_policy"
  role   = var.appsync_role_id
  policy = data.aws_iam_policy_document.api_key_table_access.json
}