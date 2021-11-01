output "vpc_id" {
    description = "VPC ID"
    value = module.vpc.vpc_id
}

output "public_subnets" {
    description = "Public Subnet List"
    value = module.vpc.public_subnets
}

output "private_subnets" {
    description = "Private Subnet List"
    value = module.vpc.private_subnets
}

output "rds_subnets" {
    description = "RDS Subnet List"
    value = module.vpc.intra_subnets
}

output "nat_public_ips" {
    description = "Public Elastic IP"
    value = module.vpc.nat_public_ips
}