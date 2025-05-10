provider "aws" {
  region = "sa-east-1"
}

resource "aws_security_group" "ec2_sg" {
  name        = "wordpress_sg"
  description = "Allow HTTP and SSH"
  vpc_id      = var.vpc_id

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

resource "aws_instance" "wordpress" {
  ami                         = var.ami_id
  instance_type              = "t2.micro"
  subnet_id                  = var.subnet_id
  vpc_security_group_ids     = [aws_security_group.ec2_sg.id]
  iam_instance_profile       = "EC2TerraformRole"
  user_data                  = file("user_data.sh")
  associate_public_ip_address = true
  tags = {
    Name = "WordPressServer"
  }
}