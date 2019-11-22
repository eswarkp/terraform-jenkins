provider "aws" {
  region  = "ap-south-1"
}

variable "image_id" {
  type = string
  default = "ami-0123b531fc646552f"
}

#Jenkins Master Instance
resource "aws_instance" "red-jenkins-master" {
  ami           = var.image_id
  instance_type = "t2.micro"
  tags = {
    Name       = "red-team-jenkins-master"
    Purpose     = "jenkins master"
    Environment = "Dev"
  }
}

#Jenkins Node Instance
resource "aws_instance" "red-jenkins-node" {
  ami           = var.image_id
  instance_type = "t2.micro"
  tags = {
    Name       = "red-team-jenkins-node"
    Purpose     = "jenkins node"
    Environment = "Dev"
  }
}


output "master" {
  value = aws_instance.red-jenkins-master.id
}

output "node" {
  value = aws_instance.red-jenkins-node.id
}


module "vpc-module" {
  source = "github.com/upesabhi/terraform.git"
}


output "vpc-output" {
  value = vpc-module
}