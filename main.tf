provider "aws" {
    region = "us-east-1"  
}

resource "aws_instance" "Instance-Proj" {
  ami           = "ami-0e2c8caa4b6378d8c" # us-east-1
  instance_type = "t2.micro"
  tags = {
      Name = "TF-Instance"
  }
}
