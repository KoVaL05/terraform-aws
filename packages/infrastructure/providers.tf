provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
      Project   = "aethera-ai-app"
      ProjectId = module.random.random_name
    }
  }
}
