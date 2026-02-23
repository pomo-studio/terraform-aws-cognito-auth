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
  region = "us-east-1"
}

module "auth" {
  source = "../../"

  name = "example-users"
}

output "user_pool_id" {
  value = module.auth.user_pool_id
}

output "client_id" {
  value = module.auth.client_id
}
