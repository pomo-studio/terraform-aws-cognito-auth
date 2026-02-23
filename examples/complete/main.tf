terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  alias  = "primary"
  region = "us-east-1"
}

module "auth" {
  source = "../../"

  providers = {
    aws = aws.primary
  }

  name        = "txwatch-users"
  client_name = "txwatch-app"

  minimum_password_length = 10
  require_symbols         = true
  mfa_configuration       = "OPTIONAL"

  tags = {
    Project     = "txwatch"
    Environment = "production"
    ManagedBy   = "terraform"
  }
}

output "user_pool_id" {
  value = module.auth.user_pool_id
}

output "client_id" {
  value = module.auth.client_id
}

output "lambda_env_vars" {
  value = module.auth.lambda_env_vars
}
