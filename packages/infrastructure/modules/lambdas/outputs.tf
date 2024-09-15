output "lambda_functions" {
  value = {
    for lambda_name, value in local.lambda_functions_data :
    lambda_name => {
      arn = aws_lambda_function.lambda_functions[lambda_name].arn
    }
  }
}
