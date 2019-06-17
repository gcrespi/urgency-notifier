resource "aws_api_gateway_account" "api_gateway_cloudwatch_account" {
  cloudwatch_role_arn = aws_iam_role.api_gateway_cloudwatch_global.arn
}

resource "aws_iam_role" "api_gateway_cloudwatch_global" {
  name = "api_gateway_cloudwatch_global"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "api_gateway_cloudwatch_global" {
  name = "default"
  role = aws_iam_role.api_gateway_cloudwatch_global.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams",
                "logs:PutLogEvents",
                "logs:GetLogEvents",
                "logs:FilterLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

output "api_gateway_account_id" {
  value = aws_api_gateway_account.api_gateway_cloudwatch_account.id
}