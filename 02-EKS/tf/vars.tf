variable "region" {
  type = string
}

# These variables (zone_id, domain_name) are obviously related, and one could probably be looked up from the other
variable "zone_id" {
  type    = string
}

variable "domain_name" {
  type = string
}

variable "base_name" {
  type    = string
}

variable "secret_word" {
  type    = string
  default = "DiligentMouse-AWS-EKS"
}

