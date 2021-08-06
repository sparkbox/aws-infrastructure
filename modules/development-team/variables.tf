variable "users" {
  type    = list(object({
    name = string
    is_enabled = bool
  }))
}

variable "pgp_key" {
  type    = string
}


