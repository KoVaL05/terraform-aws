resource "aws_iam_role" "lambda_roles" {
  for_each = local.lambda_functions

  name               = format("%s_lambda_role_%s", each.key, var.random_name)
  assume_role_policy = data.aws_iam_policy_document.basic_lambda_role.json
}

resource "aws_lambda_function" "lambda_functions" {
  for_each      = local.lambda_functions
  function_name = format("%s_%s", each.key, var.random_name)
  role          = aws_iam_role.lambda_roles[each.key].arn
  runtime       = "python3.9"
  timeout       = 60
  memory_size   = 128
  publish       = true

  handler   = "index.handler"
  s3_bucket = var.lambdas_bucket_arn
  s3_key    = format("%s/%s.zip", each.key, each.key)
}
