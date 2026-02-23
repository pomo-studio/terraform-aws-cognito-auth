output "user_pool_id" {
  description = "Cognito User Pool ID"
  value       = aws_cognito_user_pool.main.id
}

output "user_pool_arn" {
  description = "Cognito User Pool ARN"
  value       = aws_cognito_user_pool.main.arn
}

output "client_id" {
  description = "Cognito User Pool app client ID"
  value       = aws_cognito_user_pool_client.main.id
}

output "region" {
  description = "AWS region where the user pool is deployed"
  value       = data.aws_region.current.name
}

output "lambda_env_vars" {
  description = "Environment variable map for SSR/API Lambdas that perform Cognito auth calls"
  value = {
    COGNITO_USER_POOL_ID = aws_cognito_user_pool.main.id
    COGNITO_CLIENT_ID    = aws_cognito_user_pool_client.main.id
    COGNITO_REGION       = data.aws_region.current.name
  }
}

output "hosted_ui_enabled" {
  description = "Whether Cognito Hosted UI is enabled"
  value       = var.enable_hosted_ui
}

output "hosted_ui_domain" {
  description = "Cognito Hosted UI domain prefix"
  value       = var.enable_hosted_ui ? aws_cognito_user_pool_domain.main[0].domain : null
}

output "hosted_ui_signin_url" {
  description = "Cognito Hosted UI sign-in URL"
  value = var.enable_hosted_ui ? format(
    "https://%s.auth.%s.amazoncognito.com/login?client_id=%s&response_type=code&scope=%s&redirect_uri=%s",
    aws_cognito_user_pool_domain.main[0].domain,
    data.aws_region.current.name,
    aws_cognito_user_pool_client.main.id,
    urlencode(join(" ", var.oauth_scopes)),
    urlencode(var.oauth_callback_urls[0])
  ) : null
}

output "hosted_ui_signout_url" {
  description = "Cognito Hosted UI sign-out URL"
  value = var.enable_hosted_ui ? format(
    "https://%s.auth.%s.amazoncognito.com/logout?client_id=%s&logout_uri=%s",
    aws_cognito_user_pool_domain.main[0].domain,
    data.aws_region.current.name,
    aws_cognito_user_pool_client.main.id,
    urlencode(var.oauth_logout_urls[0])
  ) : null
}
