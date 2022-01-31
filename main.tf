terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web"{
    ami= "ami-08xxxxxxxxxxxx"
    instance_type = "t2.micro"

    tags = {
      Name = "Terraform Example Auth"
    }
}

module "aws_auth_function" {
  source = "./modules/authorizer"
  api_id = aws_api_gateway_rest_api.ApiGateway.id
  lambda_name = "dealers-auth"
  runtime = "nodejs14.x"
  handler = "index.handler"
  output_path = "./modules/authorizer/aws-authorizer.zip"
}
