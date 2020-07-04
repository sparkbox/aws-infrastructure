provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

variable "dev_team_members" {
  type = list(string)
}

variable "pgp_path" {
  type = string
}

module "development-team" {
  source = "./development-team/"

  users     = var.dev_team_members
  pgp_path  = var.pgp_path
}
