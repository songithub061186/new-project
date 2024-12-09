provider "aws" {
  region = "us-east-1"
}

# Get the default VPC
data "aws_vpc" "default" {
  default = true
}

# Get the default subnet in the default VPC
data "aws_subnet" "default" {
  vpc_id = data.aws_vpc.default.id
}

# Create an EC2 instance in the default subnet
resource "aws_instance" "Instance-Proj" {
  ami           = "ami-0e2c8caa4b6378d8"  # us-east-1
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.default.id  # Specify subnet ID

  tags = {
    Name = "TF-Instance"
  }
}
