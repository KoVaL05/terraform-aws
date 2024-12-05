resource "aws_iam_role" "appsync_api_key_role" {
  name               = "appsync_api_key_role"
  assume_role_policy = data.aws_iam_policy_document.appsync_assume_role.json
}