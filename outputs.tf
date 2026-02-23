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
