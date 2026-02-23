data "aws_region" "current" {}

locals {
  hosted_ui_enabled = var.enable_hosted_ui
}

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

  explicit_auth_flows = var.explicit_auth_flows

  allowed_oauth_flows_user_pool_client = local.hosted_ui_enabled
  allowed_oauth_flows                  = local.hosted_ui_enabled ? ["code"] : []
  allowed_oauth_scopes                 = local.hosted_ui_enabled ? var.oauth_scopes : []
  callback_urls                        = local.hosted_ui_enabled ? var.oauth_callback_urls : []
  logout_urls                          = local.hosted_ui_enabled ? var.oauth_logout_urls : []

  token_validity_units {
    access_token  = "hours"
    id_token      = "hours"
    refresh_token = "days"
  }

  access_token_validity  = var.access_token_validity_hours
  id_token_validity      = var.id_token_validity_hours
  refresh_token_validity = var.refresh_token_validity_days

  lifecycle {
    precondition {
      condition     = !local.hosted_ui_enabled || (var.domain_prefix != null && length(var.oauth_callback_urls) > 0 && length(var.oauth_logout_urls) > 0)
      error_message = "When enable_hosted_ui is true, domain_prefix, oauth_callback_urls, and oauth_logout_urls must be provided."
    }
  }
}

resource "aws_cognito_user_pool_domain" "main" {
  count        = local.hosted_ui_enabled ? 1 : 0
  domain       = var.domain_prefix
  user_pool_id = aws_cognito_user_pool.main.id
}
