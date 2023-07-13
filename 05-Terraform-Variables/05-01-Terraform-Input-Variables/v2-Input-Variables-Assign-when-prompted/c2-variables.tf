# Input Variables
variable "aws_region" {
  description = "Region in which AWS resources to be created"
  type        = string
  default     = "us-east-1"
}

variable "ec2_ami_id" {
  description = "AMI ID"
  type        = string
  default     = "ami-06ca3ca175f37dd66" # Amazon2 Linux AMI ID
}

variable "ec2_instance_count" {
  description = "EC2 Instance Count"
  type        = number
  default     = 1
}

variable "key_name" {
  description = "key pair name"
  type        = string
  default     = "ec2key"
}

# Assign When Prompted using CLI
variable "ec2_instance_type" {
  description = "EC2 Instance Type"
  type        = string
  #we dont define the default value to better understand the assign when prompted input variables
  #so when we run terraform plan/apply, it's going ask (prompt us) for the value of ec2_instance_type
}
