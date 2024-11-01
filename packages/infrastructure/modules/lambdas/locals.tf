locals {
  lambda_functions_data = {
    "subject_group_executor" = {
      allow_agent_execution = true
    },
     "pre_signup" = {
      allow_agent_execution = false
    },
  }
}
