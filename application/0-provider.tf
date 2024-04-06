# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "job-meeting-lab-20240408-terraform-backend-bucket"
    key    = "terraform/state"
  }
}

provider "aws" {
  region = var.aws_region
}
