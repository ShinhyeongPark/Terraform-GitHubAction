resource "aws_eip" "nat" {
    count = 1
    vpc = true
    tags = var.nat_eip_tags
}


#terraform-aws-moudes/vpc 관련 Document
#https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
#AWS에 VPC 리소스를 생성하는 모듈
module "vpc" {
    source = "terraform-aws-modules/vpc/aws"

    name = var.vpc_name
    cidr = var.vpc_cidr_block
    az = ["${var.region}a","${var.region}b"]
    public_subnet = var.public_subnet
    private_subnet = var.private_subnet
    db_subnet = var.db_subnet

    nat_gateway_single = var.nat_gateway_single
    nat_gateway_enable = var.nat_gateway_enable
    nat_gateway_one_per_az = var.nat_gateway_one_per_az
    nat_gateway_ips_reuse = var.nat_gateway_ips_reuse

    external_nat_ip_ids = aws_eip.nat.*.id

    enable_dns_host = var.enable_dns_host
    enable_dns_support = var.enable_dns_support

    vpc_tags = var.vpc_tags
    igw_tags = var.igw_tags
    nat_eip_tags = var.nat_eip_tags
    nat_gateway_tags = var.nat_gateway_tags

    subnet_suffix_public = var.subnet_suffix_public
    subnet_suffix_private = var.subnet_suffix_private
    subnet_suffix_db = var.subnet_suffix_db

    route_table_public_tags = var.route_table_public_tags
    route_table_private_tags = var.route_table_private_tags
    route_table_db_tags = var.route_table_db_tags

    subnet_public_tags = var.subnet_public_tags
    subnet_private_tags = var.subnet_private_tags
    subnet_db_tags = var.subnet_db_tags


}