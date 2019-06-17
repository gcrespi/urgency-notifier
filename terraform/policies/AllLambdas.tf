module "AllLambdas" {
  source = "../modules/policies"
}

output "lambda_apigateway_iam_role_arn" {
  value = module.AllLambdas.lambda_apigateway_iam_role_arn
}
