# resource "aws_key_pair" "wordpress-bastion-shpark" {
#     key_name = "bastion-key"
#     public = var.bastion_keypair
# }

# resoure "aws_eip_association" "eip_associ_shpark" {
#     instance_id = module.bastion_ec2.id
#     allocation_id = aws_eip.bast_eip_shpark.id
# }

# resource "aws_eip" "bast_eip_shpark" {
#   vpc = true
# }

# module "bastion_ec2" {
#     source = "terraform-aws-modules/ec2-instance/aws"
#     version = "~> 3.0"
# }

# module "bast_sg" {
#     source = "terraform-aws-modules/security-group/aws"
#     version = "~> 4.0"

#     name = var.bastion_sg_name
#     vpc_id = module.vpc.vpc_id
    
#     ingress_cidr_blocks = [var.home_ip, var.company_ip]
#     ingress_rules       = ["ssh-tcp"]
#     egress_rules        = ["all-all"]

#     tags = var.bastion_sg_tag
# }