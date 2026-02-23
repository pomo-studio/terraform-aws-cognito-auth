variable "name" {
  description = "Cognito User Pool name"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]+$", var.name))
    error_message = "Name must contain only alphanumeric characters, hyphens, underscores, and dots."
  }
}

variable "client_name" {
  description = "Cognito User Pool app client name"
  type        = string
  default     = "app"
}

variable "minimum_password_length" {
  description = "Minimum password length for local users"
  type        = number
  default     = 8

  validation {
    condition     = var.minimum_password_length >= 8 && var.minimum_password_length <= 99
    error_message = "minimum_password_length must be between 8 and 99."
  }
}

variable "require_lowercase" {
  description = "Whether passwords must include lowercase characters"
  type        = bool
  default     = true
}

variable "require_numbers" {
  description = "Whether passwords must include numeric characters"
  type        = bool
  default     = true
}

variable "require_symbols" {
  description = "Whether passwords must include symbol characters"
  type        = bool
  default     = false
}

variable "require_uppercase" {
  description = "Whether passwords must include uppercase characters"
  type        = bool
  default     = true
}

variable "explicit_auth_flows" {
  description = "Explicit auth flows enabled on the app client"
  type        = list(string)
  default = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH"
  ]
}

variable "access_token_validity_hours" {
  description = "Access token validity in hours"
  type        = number
  default     = 1
}

variable "id_token_validity_hours" {
  description = "ID token validity in hours"
  type        = number
  default     = 1
}

variable "refresh_token_validity_days" {
  description = "Refresh token validity in days"
  type        = number
  default     = 30
}

variable "email_sending_account" {
  description = "Cognito email sending account setting"
  type        = string
  default     = "COGNITO_DEFAULT"

  validation {
    condition     = contains(["COGNITO_DEFAULT", "DEVELOPER"], var.email_sending_account)
    error_message = "email_sending_account must be COGNITO_DEFAULT or DEVELOPER."
  }
}

variable "mfa_configuration" {
  description = "MFA configuration for user pool: OFF, ON, or OPTIONAL"
  type        = string
  default     = "OFF"

  validation {
    condition     = contains(["OFF", "ON", "OPTIONAL"], var.mfa_configuration)
    error_message = "mfa_configuration must be OFF, ON, or OPTIONAL."
  }
}

variable "tags" {
  description = "Tags applied to created resources"
  type        = map(string)
  default     = {}
}
