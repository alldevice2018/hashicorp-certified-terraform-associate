# Input Variables
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 Instance Type - Instance Sizing"
  type        = string
  default     = "t3.micro"
}

# IN THE DEMO, NO DEFAULT VALUES WERE PROVIDED FOR THE REGION, WE'LL PROVIDE IT here in our variables.tf file
