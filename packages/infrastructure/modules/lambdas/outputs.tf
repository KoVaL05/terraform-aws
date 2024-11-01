output "lambda_functions" {
  value = {
    for lambda_name, value in local.lambda_functions_data :
    lambda_name => {
      arn                      = aws_lambda_function.lambda_functions[lambda_name].arn
      iam_role_name            = aws_iam_role.lambda_roles[lambda_name].name
      allow_userpool_execution = value.allow_userpool_execution
      function_name            = aws_lambda_function.lambda_functions[lambda_name].function_name
    }
  }
}
