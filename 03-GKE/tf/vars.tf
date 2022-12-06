# These variables (zone_id, domain_name) are obviously related, and one could probably be looked up from the other
variable "zone_id" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
  default     = "us-central1"
}

variable "base_name" {
  type = string
}

variable "email" {
  type        = string
  description = "Email address for cert-manager communications"
}
