data "aws_iam_policy_document" "api_key_table_access" {
  statement {
    effect = "Allow"

    actions = [
      "dynamodb:*"
    ]

    resources = [
      var.api_key_table_arn
    ]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values = [
        var.api_key_appsync_arn
      ]
    }
  }
}