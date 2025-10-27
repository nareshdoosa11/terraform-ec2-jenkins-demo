provider "aws" {
  region = "us-east-1"
}

# 🔍 Get the first available VPC
data "aws_vpc" "default" {
  default = true
}

# 🔍 Get a subnet in that VPC
data "aws_subnet" "default" {
  default_for_az = true
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0360c520857e3138f"
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.default.id    # 👈 use subnet explicitly
  vpc_security_group_ids = [aws_security_group.sg.id] # 👈 reference your SG (if any)
  tags = {
    Name = "Jenkins-Terraform-EC2"
  }
}

resource "aws_security_group" "sg" {
  name        = "jenkins-tf-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
