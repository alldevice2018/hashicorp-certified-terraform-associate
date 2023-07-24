# Terraform Block
terraform {
  required_version = ">= 1.2" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  # Update Terraform Cloud Backend Block Information below
  backend "remote" {
    organization = "harsh-certified-terraf-associate_demo1" #"hcta-demo1"

    workspaces {
      name = "htca-cli-driven-demo" #"cli-driven-demo"
    }
  }
}

# Provider Block
provider "aws" {
  region = var.aws_region
}
/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/

#NB: after running terraform plan, accorking to the error msg, go to .terraform ==>>modules ==>> version.tf, COMMENT PROFILE IN THE PROVIDER BLOCK
