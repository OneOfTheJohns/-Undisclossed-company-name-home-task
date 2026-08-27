variable "apigw_name" {
  type = string
}

variable "protocol_type" {
  type = string
  default = "HTTP"
}

variable "throttling_burst_limit" {
  type = number
}

variable "throttling_rate_limit" {
  type = number
}

variable "integration_uri" {
  type = string
}

variable "integration_type" {
  type = string
  default = "AWS_PROXY"
}

variable "connection_type" {
  type = string
  default = "INTERNET"
}

variable "description" {
  type = string
  default = "for lambda processing"
}

variable "integration_method" {
  type = string
  default = "POST"
}

variable "passthrough_behavior" {
  type = string
  default = "WHEN_NO_MATCH"
}

variable "route_keys" {
  type = list(string)
  default = [ "POST /health", "GET /health" ]
}