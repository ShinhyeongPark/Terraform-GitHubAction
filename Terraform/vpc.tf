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
    azs = ["${var.region}a","${var.region}b"]
    public_subnets = var.public_subnet
    private_subnets = var.private_subnet
    intra_subnets = var.db_subnet

    single_nat_gateway = var.nat_gateway_single
    enable_nat_gateway = var.nat_gateway_enable
    one_nat_gateway_per_az = var.nat_gateway_one_per_az
    reuse_nat_ips = var.nat_gateway_ips_reuse

    external_nat_ip_ids = aws_eip.nat.*.id

    enable_dns_hostnames = var.enable_dns_host
    enable_dns_support = var.enable_dns_support

    public_subnet_suffix = var.subnet_suffix_public
    private_subnet_suffix = var.subnet_suffix_private
    intra_subnet_suffix = var.subnet_suffix_intra
    
    vpc_tags = var.vpc_tags
    igw_tags = var.igw_tags
    nat_eip_tags = var.nat_eip_tags
    nat_gateway_tags = var.nat_gateway_tags

    public_route_table_tags = var.route_table_public_tags
    private_route_table_tags = var.route_table_private_tags
    intra_route_table_tags = var.route_table_db_tags

    public_subnet_tags = var.subnet_public_tags
    private_subnet_tags = var.subnet_private_tags
    intra_subnet_tags = var.subnet_db_tags
}