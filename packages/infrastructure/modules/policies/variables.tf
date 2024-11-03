variable "random_name" {
  type = string
}

variable "lambdas_bucket_arn" {
  type = string
}

variable "lambda_functions" {
  type = map(object({
    iam_role_name : string
    permissions:map()
  }))
}

variable "user_pool_id" {
  type = string
}