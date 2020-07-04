# Sparkbox Main AWS Account Infrastructure

This repo is used to manage the Sparkbox Main AWS account using Terraform.

## How to use

1. `brew install terraform`
2. `cp local.example.tfvars local.auto.tfvars`
3. Update the variables in `local.auto.tfvars` accordingly
4. `terraform init`
3. `terraform plan`

Be sure to review what will occur.

Apply the plan via:

```
terraform apply
```
