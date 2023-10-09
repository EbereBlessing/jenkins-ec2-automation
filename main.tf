# main.tf
terraform {
 required_providers {
   aws = {
     source  = "hashicorp/aws"
     version = "~> 4.31.0"
   }
 }
}
provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "jenkins_server"{
  ami = "ami-08a52ddb321b32a8c"
  instance_type = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  associate_public_ip_address = true
  key_name = "jenkins-ssh-key"
  user_data     = file("./Install_jenkins.sh")
  tags= {
      Name = "Jenkins Installation Tutorial"     
  }
}
## ssh connectivity
resource "aws_key_pair" "jenkins_key" {
  key_name = "jenkins-ssh-key"
  public_key = file("~/.ssh/id_rsa.pub") 
}
resource "aws_s3_bucket" "jenkins_s3"{
  bucket = "jenkinstutorial-1-s3-bucket"
}

# Creating a security group named jenkins_sg
resource "aws_security_group" "jenkins_sg" {
  # Name, Description and the VPC of the Security Group
  name = "jenkins_sg"
  description = "Security group for jenkins server"
  # Since Jenkins runs on port 8080, we are allowing all traffic from the internet
  # to be able to access the EC2 instance on port 8080
  ingress {
    description = "Allow all traffic through port 8080"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Since we only want to be able to SSH into the Jenkins EC2 instance, we are only
  # allowing traffic from our IP on port 22
  ingress {
    description = "Allow SSH from my computer"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # We want the Jenkins EC2 instance to being able to talk to the internet
  egress {
    description = "Allow all outbound traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
output "instance_ip" {
  value = aws_instance.aws_ins_web.public_ip
}