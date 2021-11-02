resource "aws_key_pair" "wordpress-db-shpark" {
    key_name = "db-key"
    public_key = var.db_keypair
}

module "db_mysql_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name   = var.db_sg_name
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks = var.db_sg_cidr_blocks # 이거 바꿔 10.70.21.0/24, 10.70.22.0/24
  ingress_rules       = ["mysql-tcp"]
  egress_rules        = ["all-all"]

  tags = var.db_sg_tags
}

module "db_ssh_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name   = var.db_ssh_sg_name
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks = var.db_ssh_sg_cidr_blocks # 이거 바꿔 10.70.21.0/24, 10.70.22.0/24, 10.70.11.11/32
  ingress_rules       = ["ssh-tcp"]
  egress_rules        = ["all-all"]


  tags = var.db_ssh_sg_tags
}

# db ec2 서버를 모듈을 통해 생성합니다. 
module "db_ec2" {
  # 모듈 소스, 버전 지정
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name                   = var.db_name                                                                # 서버 이름
  ami                    = var.db_ami                                                                 # ubuntu 20.04 이미지
  instance_type          = var.db_instance_type                                                       # 인스턴스 유형
  key_name               = aws_key_pair.wordpress-bastion-shpark.key_name                         # 위에서 만든 키 이름
  vpc_security_group_ids = [module.db_mysql_sg.security_group_id, module.db_ssh_sg.security_group_id] # 위에서 생성한 security group 모듈의 id
  subnet_id              = element(module.vpc.intra_subnets, 0)                                       # vpc 모듈 public subnet 첫 번째 원소 10.70.11.0/24
  availability_zone      = element(module.vpc.azs, 0)                                                 # vpc 모듈 가용영역 속성의 첫 번째 값 1a
  private_ip             = var.db_private_ip
  tags                   = var.db_tags
}