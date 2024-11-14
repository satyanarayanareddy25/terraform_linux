# provider.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Use latest compatible version
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = var.region # Choose your preferred region
}
