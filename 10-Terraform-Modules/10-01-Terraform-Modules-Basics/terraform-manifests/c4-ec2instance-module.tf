# AWS EC2 Instance Module
module "ec2_cluster" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = "my-modules-demo"
  instance_count = 2

  ami                    = data.aws_ami.amzlinux.id
  instance_type          = "t2.micro"
  key_name               = "JENKINSHOST"
  monitoring             = true
  vpc_security_group_ids = ["sg-05c2273ef126eeb9d"]   # Get Default VPC Security Group ID and replace
  subnet_id              = "subnet-01dee7d4eb9f9562a" # Get one public subnet id from default vpc and replace
  user_data              = file("apache-install.sh")

  tags = {
    Name        = "Modules-Demo"
    Terraform   = "true"
    Environment = "dev"
  }
}

