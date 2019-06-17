variable "identification" {
  type = object({
    name = string,
    handler = string
  })
}

variable "artifact" {
  type = object({
    bucket = string,
    key_prefix = string,
    name = string,
    version = string
  })
}

variable "config" {
  type = object({
    timeout       = string,
    memory_size   = string,

    subnet_ids = list(string),
    security_group_id = string,
    lambda_apigateway_iam_role_arn = string
  })
}

variable "environment_variables" {
  type = "map"
}