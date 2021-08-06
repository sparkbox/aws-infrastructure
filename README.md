# Sparkbox Main AWS Account Infrastructure

This repo is used to manage the Sparkbox Main AWS account using Terraform.

## How to use

1. `brew install terraform`
2. `cp local.example.tfvars local.auto.tfvars`
3. Update the variables in `local.auto.tfvars` accordingly
4. `terraform init`
3. `terraform plan`

We use [Terraform Cloud] to execute our infrastructure. Commits to main will 
automatically be [Planned][tf plan] and, if successful, [Applied][tf apply].


## Contributing
Updates to our aws infrastucture should happen by making a PR to this repo.
You can `validate` changes and see the outcome of `plan`, but you cannot
`apply`, because it will impact our primary account. Instead, it is 
recommended you test modules independently against your dev sandbox.


[Terraform Cloud]: https://www.terraform.io/cloud
[tf plan]: https://www.terraform.io/docs/cli/commands/plan.html
[tf apply]: https://www.terraform.io/docs/cli/commands/apply.html
