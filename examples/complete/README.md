# Complete Cognito Auth

Shows a Cognito user pool with a custom client name, password policy, and optional MFA.

## What it creates

- A Cognito user pool named `txwatch-users` and a `txwatch-app` client.
- A password policy with a minimum length of 10 and symbols required.
- MFA set to `OPTIONAL`.
- Outputs for the pool id, client id, and Lambda environment variables.

## Before you start

- AWS provider v5 or later, in `us-east-1`.
- Uses the local module source `../../` with an aliased provider.

## Run it

```bash
terraform init
terraform plan
terraform apply
```

## Clean up

```bash
terraform destroy
```
