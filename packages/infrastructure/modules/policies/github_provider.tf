resource "aws_iam_openid_connect_provider" "github_provider" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list  = ["sts.amazonaws.com", "https://github.com/KoVaL05/aethera-project"]
  thumbprint_list = ["D89E3BD43D5D909B47A18977AA9D5CE36CEE184C"]
}