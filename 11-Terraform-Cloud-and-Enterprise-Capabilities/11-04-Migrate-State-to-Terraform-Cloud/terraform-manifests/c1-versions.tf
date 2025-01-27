# Terraform Block
terraform {
  required_version = ">= 1.2" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  # Update remote backend information
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "harsh-certified-terraf-associate_demo1" # Organization should already exists in Terraform Cloud

    workspaces {
      name = "state-migration-demo"
      # Two cases: 
      # Case-1: If workspace already exists, should not have any state files in states tab
      # Case-2: If workspace not exists, during migration it will get created
    }
  }
}

# Provider Block
provider "aws" {
  region = var.aws_region
  #profile = "default"
}
/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
configure the profile credential directly on the cli
*/
