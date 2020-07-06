provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "Sparkbox"

    workspaces {
      name = "aws-infrastructure"
    }
  }
}

variable "technical_directors" {
  type = list(string)
}

variable "dev_team_members" {
  type = list(string)
}

variable "pgp_key" {
  type = string
}

module "technical-directors" {
  source    = "./modules/technical-directors/"

  usernames = var.technical_directors
}

module "development-team" {
  source  = "./modules/development-team/"

  users   = var.dev_team_members
  pgp_key = var.pgp_key
}

module "terraform-automation" {
  source  = "./modules/terraform-automation/"

  pgp_key = var.pgp_key
}

output "terraform-automation-secret" {
  value = module.terraform-automation.secret
}

