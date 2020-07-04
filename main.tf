provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

variable "dev_team_members" {
  type = list(string)
}

variable "pgp_key" {
  type = string
}

module "development-team" {
  source = "./development-team/"

  users   = var.dev_team_members
  pgp_key = var.pgp_key
}
