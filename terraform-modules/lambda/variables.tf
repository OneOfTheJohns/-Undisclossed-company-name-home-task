variable "path_to_lambda" {
  type = string
}

variable "lambda_iam_role_arn" {
  type = string
}

variable "env_variables" {
  type = map(string)
}