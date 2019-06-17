locals {
  path = "${var.artifact.key_prefix}/${var.artifact.name}/${var.artifact.version}/${var.artifact.name}"
}

data "aws_s3_bucket_object" "hash" {
  bucket = var.artifact.bucket
  key    = "${local.path}.hash"
}

resource "aws_lambda_function" "lambda" {
  function_name = var.identification.name

  # The bucket name as created earlier with "aws s3api create-bucket"
  s3_bucket = var.artifact.bucket
  s3_key        = "${local.path}.zip"

  # "main" is the filename within the zip file (main.js) and "handler"
  # is the name of the property under which the handler function was
  # exported in that file.
  handler = var.identification.handler
  runtime = "java8"
  timeout = var.config.timeout

  memory_size   = var.config.memory_size
  publish       = true

  role = var.config.lambda_apigateway_iam_role_arn

  source_code_hash = replace(data.aws_s3_bucket_object.hash.body, "/\n$/", "")

  vpc_config {
    subnet_ids         = var.config.subnet_ids
    security_group_ids = [var.config.security_group_id]
  }

  environment {
    variables = var.environment_variables
  }
}

output "name" {
  value = aws_lambda_function.lambda.function_name
}

output "arn" {
  value = aws_lambda_function.lambda.arn
}