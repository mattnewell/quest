terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
      api_version = "client.authentication.k8s.io/v1beta1"
    }
  }
}
