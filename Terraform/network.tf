#############################################################
#              [VPC]
#############################################################
resource "aws_vpc" "vpc-demo-shpark" {
    cidr_block = "10.80.0.0/16"
}

#############################################################
#             [Internet Gateway]
#############################################################
resource "aws_internet_gateway" "igw-bastion-1a-shpark" {
    #IGW를 VPC에 연결
    vpc_id = "${aws_vpc.vpc-demo-shpark.id}"
}

#############################################################
#             [NAT]
#############################################################
resource "aws_eip" "eip-bastion-shpark" {
    vpc = true
}

resource "aws_nat_gateway" "nat-demo-1a-shpark" {
    allocation_id = "${aws_eip.eip-bastion-shpark.id}"
    subnet_id = "${aws_subnet.subnet-webapp-1a.id}"
}

#############################################################
#             [Route Table]
#############################################################
resource "aws_route_table" "rt-lsitc-bastion-shpark" {
    vpc_id = "${aws_vpc.vpc-demo-shpark.id}"
    #bastion 서버와 IGW 연결
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw-bastion-1a-shpark.id}"
    }
}

resource "aws_route_table" "rt-lsitc-webapp-shpark" {
    vpc_id = "${aws_vpc.vpc-demo-shpark.id}"
    #App 서버와 NAT 연결
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_nat_gateway.nat-demo-1a-shpark.id}"
    }
  
}

resource "aws_route_table" "rt-lsitc-rds-shpark" {
    vpc_id = "${aws_vpc.vpc-demo-shpark.id}"

}

#############################################################
#             [Subnet]
#############################################################
resource "aws_subnet" "subnet-bastion-1a" {
    vpc_id = "${aws_vpc.vpc-demo-shpark.id}"
    cidr_block = "10.80.11.0/24"
    # subnet = cidrsubnet(aws_vpc.vpc-demo-shpark, 8, 11)
    availability_zone = "us-west-1a"
}
resource "aws_subnet" "subnet-bastion-1b" {
    vpc_id = "${aws_vpc.vpc-demo-shpark.id}"
    cidr_block = "10.80.12.0/24"
    # subnet = cidrsubnet(aws_vpc.vpc-demo-shpark, 8, 12)
    availability_zone = "us-west-1b"
}
resource "aws_subnet" "subnet-webapp-1a" {
    vpc_id = "${aws_vpc.vpc-demo-shpark.id}"
    cidr_block = "10.80.21.0/24"
    # subnet = cidrsubnet(aws_vpc.vpc-demo-shpark, 8, 21)
    availability_zone = "us-west-1a"
}
resource "aws_subnet" "subnet-webapp-1b" {
    vpc_id = "${aws_vpc.vpc-demo-shpark.id}"
    cidr_block = "10.80.22.0/24"
    # subnet = cidrsubnet(aws_vpc.vpc-demo-shpark, 8, 22)
    availability_zone = "us-west-1b"
}
resource "aws_subnet" "subnet-rds-1a" {
    vpc_id = "${aws_vpc.vpc-demo-shpark.id}"
    cidr_block = "10.80.31.0/24"
    # subnet = cidrsubnet(aws_vpc.vpc-demo-shpark, 8, 31)
    availability_zone = "us-west-1a"
}
resource "aws_subnet" "subnet-rds-1b" {
    vpc_id = "${aws_vpc.vpc-demo-shpark.id}"
    cidr_block = "10.80.32.0/24"
    # subnet = cidrsubnet(aws_vpc.vpc-demo-shpark, 8, 32)
    availability_zone = "us-west-1b"
}

