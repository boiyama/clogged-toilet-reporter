# Configure the AWS Provider
provider "aws" {
  version = "~> 2.0"
  region  = "ap-northeast-1"
}

# Create a IAM role for Lambda
resource "aws_iam_role" "lambda" {
  name               = "CloggedToiletReporterLambdaRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role_lambda.json
}

data "aws_iam_policy_document" "assume_role_lambda" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "amazon_connect" {
  role       = aws_iam_role.lambda.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonConnectFullAccess"
}

// Create a Lambda function
data "archive_file" "function" {
  type        = "zip"
  source_dir  = "./dist"
  output_path = "code.zip"
}

resource "aws_lambda_function" "clogged_toilet_reporter" {
  filename         = data.archive_file.function.output_path
  source_code_hash = data.archive_file.function.output_base64sha256
  function_name    = "CloggedToiletReporter"
  handler          = "main.handler"
  role             = aws_iam_role.lambda.arn
  runtime          = "nodejs10.x"
  timeout          = 60
  environment {
    variables = {
      INSTANCE_ID              = var.INSTANCE_ID
      CONTACT_FLOW_ID          = var.CONTACT_FLOW_ID
      SOURCE_PHONE_NUMBER      = var.SOURCE_PHONE_NUMBER
      DESTINATION_PHONE_NUMBER = var.DESTINATION_PHONE_NUMBER
    }
  }
}

variable "INSTANCE_ID" {}
variable "CONTACT_FLOW_ID" {}
variable "SOURCE_PHONE_NUMBER" {}
variable "DESTINATION_PHONE_NUMBER" {}
