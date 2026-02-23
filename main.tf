data "aws_region" "current" {}

resource "aws_cognito_user_pool" "main" {
  name = var.name

  password_policy {
    minimum_length    = var.minimum_password_length
    require_lowercase = var.require_lowercase
    require_numbers   = var.require_numbers
    require_symbols   = var.require_symbols
    require_uppercase = var.require_uppercase
  }

  schema {
    attribute_data_type = "String"
    name                = "email"
    required            = true
    mutable             = false
  }

  auto_verified_attributes = ["email"]
  mfa_configuration        = var.mfa_configuration

  email_configuration {
    email_sending_account = var.email_sending_account
  }

  tags = var.tags
}

resource "aws_cognito_user_pool_client" "main" {
  name         = var.client_name
  user_pool_id = aws_cognito_user_pool.main.id

  generate_secret = false

  explicit_auth_flows                  = var.explicit_auth_flows
  allowed_oauth_flows_user_pool_client = false

  token_validity_units {
    access_token  = "hours"
    id_token      = "hours"
    refresh_token = "days"
  }

  access_token_validity  = var.access_token_validity_hours
  id_token_validity      = var.id_token_validity_hours
  refresh_token_validity = var.refresh_token_validity_days
}
