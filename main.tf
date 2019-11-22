provider "aws" {
  region = "ap-south-1"
}

variable "image_id" {
  type    = string
  default = "ami-0123b531fc646552f"
}


module "vpc-module" {
  source = "github.com/upesabhi/redteam.git?ref=v0.0.3"
}

output "vpc-output" {
  value = module.vpc-module.vpcid
}

#Jenkins Master Instance
resource "aws_instance" "red-jenkins-master" {
  ami                    = var.image_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.vpc-module.sgmaster]
  tags = {
    Name        = "red-team-jenkins-master"
    Purpose     = "jenkins master"
    Environment = "Dev"
  }
}

#Jenkins Node Instance
resource "aws_instance" "red-jenkins-node" {
  ami                    = var.image_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.vpc-module.sgnode]
  tags = {
    Name        = "red-team-jenkins-node"
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

output "masterpublicip" {
  value = aws_instance.red-jenkins-master.public_ip
}

output "nodepublicip" {
  value = aws_instance.red-jenkins-node.public_ip
}

output "inventory" {
  value = "jenkins ansible_host=${aws_instance.red-jenkins-master.public_ip} ansible_user=ubuntu"
}
