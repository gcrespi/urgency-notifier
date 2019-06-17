terraform {
  backend "s3" {}
}

locals {
  model_artifact = {
    bucket     = "poc-aws-gcrespi-east"
    key_prefix = "bla"
    name = "ble"
    version = "v2.0.0"
  }

  default_env_variables = {
    "APP_ENV"           = "prod"
    "DB_APP_USER"       = "app_user"
    "DB_APP_PASSWORD"   = "app_pass"
    "DB_URL"            = "db_url"
  }

  lambda_identification = {
    name        = "BleService"
    handler       = "aws.lambda.poc.accounts.handlers.CreateAccountHandler"
  }

  model_config = {
    timeout       = "30"
    memory_size   = "512"

    subnet_ids = []
    security_group_id = ""
    lambda_apigateway_iam_role_arn = module.policies.lambda_apigateway_iam_role_arn
  }
// TODO esto no existe por ahora
//  config_type = object({
//    timeout       = string,
//    memory_size   = string,
//
//    subnet_ids = list(string),
//    security_group_id = string,
//    lambda_apigateway_iam_role_arn = string
//  })
}


module "policies" {
  source = "./policies"
}


module "CreateAccountService" {
  source = "./modules/lambda"

  identification = local.lambda_identification
  artifact = local.model_artifact
  config = local.model_config
  environment_variables = local.default_env_variables
}