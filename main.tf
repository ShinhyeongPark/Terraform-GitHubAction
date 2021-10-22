#AWS CLI Version
terraform {
    required_providers{
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.27"
        }
        random = {
            source  = "hashicorp/random"
            version = "3.0.1"
    }
    }
    required_version = ">= 0.14.9"

    backend "remote" {
        organization = "lsitc-sypark"

        workspaces {
            name = "gh-actions-sypark"
        }
    }
}

#가용 리전 정의
provider "aws" {
    profile = "default"
    region = "us-west-2"
}

#############################################################
#              [Security Group-Bastion Server]
#############################################################
resource "aws_security_group" "bastion_server" {
    name = "allow_to_bastion_server"
    description = "Inbound Rule Bastion Server"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["211.168.91.10/32"] # My IP
    }
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["10.80.21.0/24"] # My IP
    }
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["10.80.22.0/24"] # My IP
    }
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["10.80.23.0/24"] # My IP
    }
}
#############################################################
#              [Security Group-App Server]
#############################################################
resource "aws_security_group" "app_server" {
    name = "allow_to_app_server"
    description = "Inbound Rule App Server"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["211.168.91.10/32"] # My IP
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["10.80.11.0/24"] # My IP
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # My IP
    }
}

#############################################################
#              [EC2 Instance]
#############################################################
#Instance [Bastion, App]
resource "aws_instance" "bastion_server" {
    ami = "ami-03d5c68bab01f3496" #Ubuntu Server 20.04 LTS AMI
    instance_type = "t2.micro"
    vpc_security_group_ids = [ "${aws_security_group.bastion_server.id}" ]

    tags = {
        Name = "Bastion-public"
    }
}

resource "aws_instance" "app_server" {
    ami = "ami-03d5c68bab01f3496" #Ubuntu Server 20.04 LTS AMI
    instance_type = "t2.micro"
    vpc_security_group_ids = [ "${aws_security_group.app_server.id}" ]
    tags = {
        Name = "app-private"
    }
}

#############################################################
#              [EC2 KeyPair]
#############################################################
resource "aws_key_pair" "bastion_server" {
    key_name = "bastion_server"
    public_key = file("~/.ssh/bastion_server.pub")
}

resource "aws_key_pair" "app_server" {
    key_name = "app_server"
    public_key = file("~/.ssh/app_server.pub")
}

