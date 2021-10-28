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

    tags {
        Name = "Bastion-public"
    }
}

resource "aws_instance" "app_server" {
    ami = "ami-03d5c68bab01f3496" #Ubuntu Server 20.04 LTS AMI
    instance_type = "t2.micro"
    vpc_security_group_ids = [ "${aws_security_group.app_server.id}" ]
    tags {
        Name = "app-private"
    }
}

#############################################################
#              [VPC]
#############################################################
resource "aws_vpc" "vpc-demo-shpark" {
    cidr_block = "10.80.0.0/16"

    tags {
        Name = "VPC"
    }
}

#############################################################
#             [Internet Gateway]
#############################################################
resource "aws_internet_gateway" "igw-bastion-1a-shpark" {
    #IGW를 VPC에 연결
    vpc_id = "${aws_vpc.vpc-demo-shpark.id}"

    tags {
        Name = "IGW"
    }
}

#############################################################
#             [NAT]
#############################################################
resource "aws_eip" "eip-bastion-shpark" {
    vpc = true
}

resource "aws_nat_gateway" "nat-demo-1a-shpark" {
    allocation_id = "${aws_eip.eip-bastion-shpark.id}"
    subnet_id = "${aws_subnet.subnet-webapp-1a}"
}

#############################################################
#             [Route Table]
#############################################################
resource "aws_route_table" "rt-lsitc-bastion-shpark" {
    vpc_id = "${aws_vpc.vpc-demo-shpark}"
    #bastion 서버와 IGW 연결
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw-bastion-1a-shpark.id}"
    }
}

resource "aws_route_table" "rt-lsitc-webapp-shpark" {
    vpc_id = "${aws_vpc.vpc-demo-shpark}"
    #App 서버와 NAT 연결
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_nat_gateway.nat-demo-1a-shpark}"
    }
  
}

resource "aws_route_table" "rt-lsitc-rds-shpark" {
    vpc_id = "${aws_vpc.vpc-demo-shpark}"

}

#############################################################
#             [Subnet]
#############################################################
resource "aws_subnet" "subnet-bastion-1a" {
    vpc_id = "${aws_vpc.vpc-demo-shpark}"
    cidr_block = "10.80.11.0/24"
    #subnet = cidrsubnet(aws_vpc.vpc-demo-shpark, 8, 11)
    availability_zone = "us-west-1a"
}
resource "aws_subnet" "subnet-bastion-1b" {
    vpc_id = "${aws_vpc.vpc-demo-shpark}"
    cidr_block = "10.80.12.0/24"
    #subnet = cidrsubnet(aws_vpc.vpc-demo-shpark, 8, 12)
    availability_zone = "us-west-1b"
}
resource "aws_subnet" "subnet-webapp-1a" {
    vpc_id = "${aws_vpc.vpc-demo-shpark}"
    cidr_block = "10.80.21.0/24"
    #subnet = cidrsubnet(aws_vpc.vpc-demo-shpark, 8, 21)
    availability_zone = "us-west-1a"
}
resource "aws_subnet" "subnet-webapp-1b" {
    vpc_id = "${aws_vpc.vpc-demo-shpark}"
    cidr_block = "10.80.22.0/24"
    #subnet = cidrsubnet(aws_vpc.vpc-demo-shpark, 8, 22)
    availability_zone = "us-west-1b"
}
resource "aws_subnet" "subnet-rds-1a" {
    vpc_id = "${aws_vpc.vpc-demo-shpark}"
    cidr_block = "10.80.31.0/24"
    #subnet = cidrsubnet(aws_vpc.vpc-demo-shpark, 8, 31)
    availability_zone = "us-west-1a"
}
resource "aws_subnet" "subnet-rds-1b" {
    vpc_id = "${aws_vpc.vpc-demo-shpark}"
     cidr_block = "10.80.32.0/24"
    #subnet = cidrsubnet(aws_vpc.vpc-demo-shpark, 8, 32)
    availability_zone = "us-west-1b"
}

#############################################################
#             [Subnet <-> Routing Table]
#############################################################
resource "aws_route_table_association" "rt-bastion-shpark-association" {
    route_table_id = aws_route_table.rt-lsitc-bastion-shpark.ids
    subnet_id = var.bastion-rt-subnet

}
resource "aws_route_table_association" "rt-webapp-shpark-association" {
    route_table_id = aws_route_table.rt-lsitc-webapp-shpark.id
    subnet_id = var.webapp-rt-subnet
}
resource "aws_route_table_association" "rt-rds-shpark-association" {
    route_table_id = aws_route_table.rt-lsitc-rds-shpark.id
    subnet_id = var.rds-rt-subnet
}
