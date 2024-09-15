provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
      Project   = "terraform-aws-ai-app"
      ProjectId = module.random.random_name
    }
  }
}
