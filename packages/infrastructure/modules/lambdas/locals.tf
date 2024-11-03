locals {
  lambda_functions_data = {
    "subject_group_executor" = {
      allow_agent_execution    = true
      allow_userpool_execution = false
      permissions = {
        link_users = false
      }
    },
    "pre_signup" = {
      allow_agent_execution    = false
      allow_userpool_execution = true
      permissions = {
        link_users = true
      }
    },
  }
}
