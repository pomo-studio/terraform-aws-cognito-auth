# Changelog

All notable changes to this module are documented here. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and versions follow [Semantic Versioning](https://semver.org/).

## [1.1.2] - 2026-09-05

### Added

- CHANGELOG.md

## [1.1.1] - 2026-09-04

### Added

- CI and release workflows
- `.tflint.hcl` lint configuration
- README badges
- Committed Terraform lock files

### Changed

- AWS provider version constraint to `>= 5.0, < 7.0`
- Bumped examples to current versions

## [1.0.0] - 2026-02-22

### Added

- Initial release
- Cognito User Pool with email-first schema and auto-verified email
- Cognito User Pool app client with password, SRP, and refresh auth flows
- Configurable password policy, MFA mode, token validity, and email sending mode
- `lambda_env_vars` output map for SSR/API Lambda integration
- Unit test suite using `terraform test` with mock providers
- Basic and complete examples

[1.1.2]: https://github.com/pomo-studio/terraform-aws-cognito-auth/releases/tag/v1.1.2
[1.1.1]: https://github.com/pomo-studio/terraform-aws-cognito-auth/releases/tag/v1.1.1
[1.0.0]: https://github.com/pomo-studio/terraform-aws-cognito-auth/releases/tag/v1.0.0

> Historical releases are documented in [GitHub Releases](https://github.com/pomo-studio/terraform-aws-cognito-auth/releases).
