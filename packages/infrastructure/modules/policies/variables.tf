variable "random_name" {
  type = string
}

variable "lambdas_bucket_arn" {
  type = string
}

variable "lambda_functions" {
  type = map(object({
    iam_role_name : string
  }))
}