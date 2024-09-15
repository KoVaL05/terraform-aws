data "aws_iam_policy_document" "lambda_policies" {
  for_each = var.lambda_functions

  statement {
    sid = "RoleForBasicLambdaLogs"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
  }

  statement {
    sid = "RoleForVPCManagement"
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface"
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
  }
}