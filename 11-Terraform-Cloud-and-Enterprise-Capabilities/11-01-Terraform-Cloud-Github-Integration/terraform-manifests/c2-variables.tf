# Input Variables
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type - Instance Sizing"
  type        = string
}

#NB: WE'RE GOING TO SET OUR DEFAULT VALUES IN TERRAFORM CLOUD DIRECTLY THAT'S WHY THERE ARE REMOVED HERE
