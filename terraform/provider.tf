terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" # It is recommended to pin a version
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}