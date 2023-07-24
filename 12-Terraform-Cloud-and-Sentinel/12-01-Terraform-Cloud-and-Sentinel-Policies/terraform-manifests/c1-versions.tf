# Terraform Block
terraform {
  required_version = ">= 1.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  # Update backend information as Terraform Cloud
  backend "remote" {
    organization = "harsh-certified-terraf-associate_demo1"

    workspaces {
      name = "hcta-sentinel-demo1"
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

/* terraform {
  cloud {
    organization = "harsh-certified-terraf-associate_demo1"

    workspaces {
      name = "hcta-sentinel-demo1"
    }
  }
} */
