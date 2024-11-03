data "aws_iam_policy_document" "lambda_policies" {
  for_each = var.lambda_functions

  statement {
    sid = "RoleForLambdaLogs"
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

  dynamic "statement" {
     for_each = each.value.link_users? [each.key] : []

    content {
      sid = "RoleForLinkingUsers"
      actions = [
        "cognito-idp:ListUsers",
        "cognito-idp:AdminLinkProviderForUser"
      ]
      effect = "Allow"
      resources = [
        format("arn:aws:cognito-idp:%s:%s:%s", data.aws_region.current.name, data.aws_caller_identity.current.account_id,var.user_pool_id)
      ]
    }
  }
}