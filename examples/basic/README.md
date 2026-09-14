# Basic Cognito Auth

Shows a minimal Cognito user pool and app client.

## What it creates

- A Cognito user pool named `example-users`.
- An app client for that pool.
- Outputs for the user pool id and client id.

## Before you start

- AWS provider v5 or later, in `us-east-1`.
- Uses the local module source `../../`.

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
