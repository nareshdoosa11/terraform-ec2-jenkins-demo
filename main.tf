provider "aws" {
  region = "us-east-1"
}

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get a default subnet
data "aws_subnet" "default" {
  default_for_az = true
}

# Security group inside that VPC
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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

# EC2 instance
resource "aws_instance" "my_ec2" {
  ami           = "ami-0360c520857e3138f"
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.default.id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  tags = {
    Name = "Jenkins-Terraform-EC2"
  }
}
