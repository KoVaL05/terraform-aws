variable "random_name" {
  type = string
}

variable "gcp_web_client_secret" {
  type = string
}

variable "gcp_web_client_id" {
  type = string
}

variable "lambda_functions" {
  type = map(object({
    allow_userpool_execution : bool
    arn : string,
    function_name : string
  }))
}