/* # Create vpc
resource "aws_vpc" "dev_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "dev-vpc"
  }
}

# Create internet gateway
resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name = "dev-igw"
  }
}

# Create public subnet az1
resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a" #create var.availability_zone if want to use a variable for the subnet creation 
  map_public_ip_on_launch = true
  tags = {
    Name = "public subnet az1"
  }
}

# create route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_igw.id
  }

  tags = {
    Name = "public route table"
  }
}

# public route table subnet association
resource "aws_route_table_association" "public_subnet_rt_association" {
  subnet_id      = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.public_route_table.id
} */
