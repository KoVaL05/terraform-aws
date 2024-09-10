terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "AWS-app-project"
    workspaces {
      name = "terraform-aws"
    }
  }
}