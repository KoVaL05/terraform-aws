module "random" {
  source = "./modules/random"
}

module "policies" {
  source = "./modules/policies"
}

module "bedrock" {
  source      = "./modules/bedrock"
  random_name = module.random.random_name
}

module "action_groups" {
  source           = "./modules/action-groups"
  subject_agent_id = module.bedrock.subject_agent_id
}

module "lambdas" {
  source      = "./modules/lambdas"
  random_name = module.random.random_name
}