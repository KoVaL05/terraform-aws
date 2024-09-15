resource "aws_iam_role" "github_assume_role_oicd" {
  name               = format("github_oicd_role_%s", var.random_name)
  assume_role_policy = data.aws_iam_policy_document.github_iam_policy_document.json
}