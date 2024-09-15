module "random" {
  source = "./modules/random"
}

module "policies" {
  source             = "./modules/policies"
  random_name        = module.random.random_name
  lambdas_bucket_arn = module.s3.lambdas_bucket_arn
}

module "bedrock" {
  source                 = "./modules/bedrock"
  random_name            = module.random.random_name
  subject_agent_role_arn = module.policies.subject_agent_role_arn
}

module "action_groups" {
  source             = "./modules/action-groups"
  subject_agent_id   = module.bedrock.subject_agent_id
  subject_lambda_arn = module.lambdas.lambda_functions["subject_group_executor"].arn
}

module "lambdas" {
  source             = "./modules/lambdas"
  random_name        = module.random.random_name
  lambdas_bucket_arn = module.s3.lambdas_bucket_arn
}

module "s3" {
  source      = "./modules/s3"
  random_name = module.random.random_name
}
