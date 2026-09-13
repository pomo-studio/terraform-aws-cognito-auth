# terraform-aws-cognito-auth

[![Terraform Validation](https://github.com/pomo-studio/terraform-aws-cognito-auth/actions/workflows/terraform.yml/badge.svg)](https://github.com/pomo-studio/terraform-aws-cognito-auth/actions/workflows/terraform.yml)
[![Terraform Registry](https://img.shields.io/badge/terraform-registry-844FBA?logo=terraform)](https://registry.terraform.io/modules/pomo-studio/cognito-auth/aws)

- [Changelog](CHANGELOG.md)

Terraform module for AWS Cognito User Pool + App Client auth patterns.

- Email-first user pool with auto-verified email
- App client configured for password + SRP + refresh flows
- Optional Cognito Hosted UI domain + OAuth code flow wiring
- Opinionated defaults for SSR/API server auth usage
- Lambda-friendly output map (`lambda_env_vars`) for direct wiring

**Registry**: `pomo-studio/cognito-auth/aws`

## Usage

### Basic

```hcl
provider "aws" {
  region = "us-east-1"
}

module "auth" {
  source  = "pomo-studio/cognito-auth/aws"
  version = "~> 1.0"

  name = "txwatch-users"
}
```

### Complete

```hcl
provider "aws" {
  alias  = "primary"
  region = "us-east-1"
}

module "auth" {
  source  = "pomo-studio/cognito-auth/aws"
  version = "~> 1.0"

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
  }
}
```

### Hosted UI (OAuth code flow)

```hcl
module "auth" {
  source  = "pomo-studio/cognito-auth/aws"
  version = "~> 1.0"

  name        = "txwatch-users"
  client_name = "txwatch-app"

  enable_hosted_ui   = true
  domain_prefix      = "txwatch-137064409667"
  oauth_callback_urls = ["https://txwatch.pomo.dev/api/auth/callback"]
  oauth_logout_urls   = ["https://txwatch.pomo.dev/login"]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0, < 7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.64.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cognito_user_pool.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool) | resource |
| [aws_cognito_user_pool_client.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client) | resource |
| [aws_cognito_user_pool_domain.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_domain) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_token_validity_hours"></a> [access\_token\_validity\_hours](#input\_access\_token\_validity\_hours) | Access token validity in hours | `number` | `1` | no |
| <a name="input_client_name"></a> [client\_name](#input\_client\_name) | Cognito User Pool app client name | `string` | `"app"` | no |
| <a name="input_domain_prefix"></a> [domain\_prefix](#input\_domain\_prefix) | Cognito Hosted UI domain prefix (required when enable\_hosted\_ui = true) | `string` | `null` | no |
| <a name="input_email_sending_account"></a> [email\_sending\_account](#input\_email\_sending\_account) | Cognito email sending account setting | `string` | `"COGNITO_DEFAULT"` | no |
| <a name="input_enable_hosted_ui"></a> [enable\_hosted\_ui](#input\_enable\_hosted\_ui) | Enable Cognito Hosted UI OAuth flows | `bool` | `false` | no |
| <a name="input_explicit_auth_flows"></a> [explicit\_auth\_flows](#input\_explicit\_auth\_flows) | Explicit auth flows enabled on the app client | `list(string)` | <pre>[<br/>  "ALLOW_USER_PASSWORD_AUTH",<br/>  "ALLOW_REFRESH_TOKEN_AUTH",<br/>  "ALLOW_USER_SRP_AUTH"<br/>]</pre> | no |
| <a name="input_id_token_validity_hours"></a> [id\_token\_validity\_hours](#input\_id\_token\_validity\_hours) | ID token validity in hours | `number` | `1` | no |
| <a name="input_mfa_configuration"></a> [mfa\_configuration](#input\_mfa\_configuration) | MFA configuration for user pool: OFF, ON, or OPTIONAL | `string` | `"OFF"` | no |
| <a name="input_minimum_password_length"></a> [minimum\_password\_length](#input\_minimum\_password\_length) | Minimum password length for local users | `number` | `8` | no |
| <a name="input_name"></a> [name](#input\_name) | Cognito User Pool name | `string` | n/a | yes |
| <a name="input_oauth_callback_urls"></a> [oauth\_callback\_urls](#input\_oauth\_callback\_urls) | OAuth callback URLs for Hosted UI | `list(string)` | `[]` | no |
| <a name="input_oauth_logout_urls"></a> [oauth\_logout\_urls](#input\_oauth\_logout\_urls) | OAuth logout URLs for Hosted UI | `list(string)` | `[]` | no |
| <a name="input_oauth_scopes"></a> [oauth\_scopes](#input\_oauth\_scopes) | OAuth scopes for Hosted UI | `list(string)` | <pre>[<br/>  "openid",<br/>  "email",<br/>  "profile"<br/>]</pre> | no |
| <a name="input_refresh_token_validity_days"></a> [refresh\_token\_validity\_days](#input\_refresh\_token\_validity\_days) | Refresh token validity in days | `number` | `30` | no |
| <a name="input_require_lowercase"></a> [require\_lowercase](#input\_require\_lowercase) | Whether passwords must include lowercase characters | `bool` | `true` | no |
| <a name="input_require_numbers"></a> [require\_numbers](#input\_require\_numbers) | Whether passwords must include numeric characters | `bool` | `true` | no |
| <a name="input_require_symbols"></a> [require\_symbols](#input\_require\_symbols) | Whether passwords must include symbol characters | `bool` | `false` | no |
| <a name="input_require_uppercase"></a> [require\_uppercase](#input\_require\_uppercase) | Whether passwords must include uppercase characters | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to created resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | Cognito User Pool app client ID |
| <a name="output_hosted_ui_domain"></a> [hosted\_ui\_domain](#output\_hosted\_ui\_domain) | Cognito Hosted UI domain prefix |
| <a name="output_hosted_ui_enabled"></a> [hosted\_ui\_enabled](#output\_hosted\_ui\_enabled) | Whether Cognito Hosted UI is enabled |
| <a name="output_hosted_ui_signin_url"></a> [hosted\_ui\_signin\_url](#output\_hosted\_ui\_signin\_url) | Cognito Hosted UI sign-in URL |
| <a name="output_hosted_ui_signout_url"></a> [hosted\_ui\_signout\_url](#output\_hosted\_ui\_signout\_url) | Cognito Hosted UI sign-out URL |
| <a name="output_lambda_env_vars"></a> [lambda\_env\_vars](#output\_lambda\_env\_vars) | Environment variable map for SSR/API Lambdas that perform Cognito auth calls |
| <a name="output_region"></a> [region](#output\_region) | AWS region where the user pool is deployed |
| <a name="output_user_pool_arn"></a> [user\_pool\_arn](#output\_user\_pool\_arn) | Cognito User Pool ARN |
| <a name="output_user_pool_id"></a> [user\_pool\_id](#output\_user\_pool\_id) | Cognito User Pool ID |
<!-- END_TF_DOCS -->

## What it creates

Per module call:
- `aws_cognito_user_pool`
- `aws_cognito_user_pool_client`
- `aws_cognito_user_pool_domain` (when `enable_hosted_ui = true`)

## Design decisions

**No app client secret by default** — this matches SSR/API Lambda auth patterns where server-side handlers call `InitiateAuth` without client-secret hashing complexity.

**Email-first pool** — the module standardizes on required and auto-verified email to reduce per-app Cognito drift.

**Primary-region only by design** — Cognito native multi-region replication is limited; DR strategy remains app-level and documented outside this module.

## License

MIT
