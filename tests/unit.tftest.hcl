mock_provider "aws" {
  mock_resource "aws_cognito_user_pool" {
    defaults = {
      id  = "us-east-1_TESTPOOL"
      arn = "arn:aws:cognito-idp:us-east-1:123456789012:userpool/us-east-1_TESTPOOL"
    }
  }

  mock_resource "aws_cognito_user_pool_client" {
    defaults = {
      id = "testclientid"
    }
  }

  mock_data "aws_region" {
    defaults = {
      name = "us-east-1"
    }
  }
}

run "basic_defaults" {
  command = plan

  variables {
    name = "test-users"
  }

  assert {
    condition     = aws_cognito_user_pool.main.name == "test-users"
    error_message = "User pool name should match var.name"
  }

  assert {
    condition     = aws_cognito_user_pool_client.main.name == "app"
    error_message = "Default client name should be app"
  }

  assert {
    condition     = output.lambda_env_vars.COGNITO_REGION == "us-east-1"
    error_message = "lambda_env_vars should expose current region"
  }
}

run "optional_mfa" {
  command = plan

  variables {
    name              = "test-users"
    mfa_configuration = "OPTIONAL"
  }

  assert {
    condition     = aws_cognito_user_pool.main.mfa_configuration == "OPTIONAL"
    error_message = "MFA should be OPTIONAL when configured"
  }
}

run "invalid_name" {
  command = plan

  expect_failures = [var.name]

  variables {
    name = "invalid name with spaces"
  }
}

run "invalid_mfa_configuration" {
  command = plan

  expect_failures = [var.mfa_configuration]

  variables {
    name              = "test-users"
    mfa_configuration = "MANDATORY"
  }
}
