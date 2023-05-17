# Todo add cloudflare resources + organize local variables in locals.tf

# Terraform initialization
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.67.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.3.0"
    }
  }
}

# Providers
provider "aws" {
  region     = local.AWS_REGION
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}

provider "cloudflare" {
  api_token = var.CLOUDFLARE_API_TOKEN
}

# Resources
# AWS App Runner
resource "aws_apprunner_service" "web-service" {
  service_name = "web-service"

  source_configuration {
    code_repository {
      code_configuration {
        code_configuration_values {
          build_command = "npm install && npm run build"
          port          = "3000"
          runtime       = "NODEJS_16"
          start_command = "npm start"

          runtime_environment_variables = local.APPRUNNER_RUNTIME_ENVIRONMENT_VARIABLES
        }
        configuration_source = "API"
      }

      repository_url = "https://github.com/textual-org/web-service"
      source_code_version {
        type  = "BRANCH"
        value = "main"
      }
    }
  }
}

# AWS SQS
resource "aws_sqs_queue" "sqs" {
  name                      = "queue"
  max_message_size          = 2048 # 2KB
  message_retention_seconds = 345600 # 4 days, how long is the message stored
  receive_wait_time_seconds = 10 
  
  #redrive_policy = jsonencode({ # dead letter queue - how does that work?
  #  deadLetterTargetArn = aws_sqs_queue.terraform_queue_deadletter.arn
  #  maxReceiveCount     = 4
  #})


}

# TODO Cloudflare domain and zone resources