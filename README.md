# terraform-aws-cognito-auth

Terraform module for AWS Cognito User Pool + App Client auth patterns.

- Email-first user pool with auto-verified email
- App client configured for password + SRP + refresh flows
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

## Variables

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `name` | `string` | required | Cognito User Pool name |
| `client_name` | `string` | `"app"` | Cognito User Pool app client name |
| `minimum_password_length` | `number` | `8` | Minimum password length for local users |
| `require_lowercase` | `bool` | `true` | Whether passwords must include lowercase characters |
| `require_numbers` | `bool` | `true` | Whether passwords must include numeric characters |
| `require_symbols` | `bool` | `false` | Whether passwords must include symbol characters |
| `require_uppercase` | `bool` | `true` | Whether passwords must include uppercase characters |
| `explicit_auth_flows` | `list(string)` | `[...]` | Explicit auth flows enabled on the app client |
| `access_token_validity_hours` | `number` | `1` | Access token validity in hours |
| `id_token_validity_hours` | `number` | `1` | ID token validity in hours |
| `refresh_token_validity_days` | `number` | `30` | Refresh token validity in days |
| `email_sending_account` | `string` | `"COGNITO_DEFAULT"` | Cognito email sending account setting |
| `mfa_configuration` | `string` | `"OFF"` | MFA configuration: `OFF`, `ON`, or `OPTIONAL` |
| `tags` | `map(string)` | `{}` | Tags applied to created resources |

## Outputs

| Name | Description |
|------|-------------|
| `user_pool_id` | Cognito User Pool ID |
| `user_pool_arn` | Cognito User Pool ARN |
| `client_id` | Cognito User Pool app client ID |
| `region` | AWS region where the user pool is deployed |
| `lambda_env_vars` | Environment variable map for SSR/API Lambdas |

## What it creates

Per module call:
- `aws_cognito_user_pool`
- `aws_cognito_user_pool_client`

## Design decisions

**No app client secret by default** — this matches SSR/API Lambda auth patterns where server-side handlers call `InitiateAuth` without client-secret hashing complexity.

**Email-first pool** — the module standardizes on required and auto-verified email to reduce per-app Cognito drift.

**Primary-region only by design** — Cognito native multi-region replication is limited; DR strategy remains app-level and documented outside this module.

## Requirements

| Tool | Version |
|------|---------|
| Terraform | `>= 1.5.0` |
| AWS provider | `~> 5.0` |

## License

MIT
