# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-02-22

### Added
- Initial release
- Cognito User Pool with email-first schema and auto-verified email
- Cognito User Pool app client with password, SRP, and refresh auth flows
- Configurable password policy, MFA mode, token validity, and email sending mode
- `lambda_env_vars` output map for SSR/API Lambda integration
- Unit test suite using `terraform test` with mock providers
- Basic and complete examples

[1.0.0]: https://github.com/pomo-studio/terraform-aws-cognito-auth/releases/tag/v1.0.0
