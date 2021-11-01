#App Instance 설정파일
resource "aws_key_pair" "wordpress-app-shpark" {
    key_name = "app-key"
    public_key = var.app_keypair
}

module "alb_http_sg" {
     # Security Group 모듈 안의 http-80 서브 모듈을 활용해서 http Security Group를 완성
    source  = "terraform-aws-modules/security-group/aws//modules/http-80"
    version = "~> 4.0"

    name   = var.alb_http_sg_name # 이름
    vpc_id = module.vpc.vpc_id    # 생성한 VPC id

    ingress_cidr_blocks = ["0.0.0.0/0"] # 어디서든 http를 통해 웹을 접속할 수 있게 전부다 열어줌

    tags = var.alb_http_sg_tags # 태그 
}

module "asg_ssh_sg" {
    source  = "terraform-aws-modules/security-group/aws"
    version = "~> 4.0"

    name   = var.asg_ssh_sg_name
    vpc_id = module.vpc.vpc_id

    ingress_cidr_blocks = var.asg_ssh_sg_cidr_blocks
    ingress_rules       = ["ssh-tcp"]
    egress_rules        = ["all-all"]

    tags = var.asg_ssh_sg_tags
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = var.alb_name # 이름

  vpc_id          = module.vpc.vpc_id                      # VPC id 
  subnets         = module.vpc.public_subnets              # public subnet 대역에 ALB를 만들어야 다른 네트워크 영역에서 웹에 접근이 가능
  security_groups = [module.alb_http_sg.security_group_id] # Security Group(HTTP) 연결

  # HTTP 관련 설정
  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  # 타겟 그룹 관련 설정
  target_groups = [
    {
      name             = var.alb_tag_name
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    },
  ]

  tags = var.alb_tags # 태그
}

module "asg_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name   = var.asg_sg_name   # 이름 
  vpc_id = module.vpc.vpc_id # VPC id

  # ALB에서 만든 Security Group을 가지고 와서 Security Group을 만든다. 
  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.alb_http_sg.security_group_id # ALB에서 만든 HTTP Security Group id
    }
  ]

  number_of_computed_ingress_with_source_security_group_id = 1 # computed_ingress_with_source_security_group_id 갯수

  egress_rules = ["all-all"] # outbound 전체로 열어준다. 

  tags = var.asg_sg_tags # 태그
}

module "default_lt" {
  source = "terraform-aws-modules/autoscaling/aws"

  name = var.asg_lt_name # 이름

  vpc_zone_identifier       = module.vpc.private_subnets # 애플리케이션 서브넷인 private subnet을 설정한다. 
  min_size                  = var.asg_min_size               # 애플리케이션 최소 갯수
  max_size                  = var.asg_max_size               # 애플리케이션 최대 갯수
  desired_capacity          = var.asg_desired_capacity       # 항상 running 상태여야 하는 애플리케이션 서버 갯수
  wait_for_capacity_timeout = 0                          # ASG instance 상태의 healthy가 뜰 때까지 기다리는 시간. 0으로 하면 계속 기다린다.
  enable_monitoring         = true                       # 모니터링

  # launch template 사용 여부를 bool 형태로 설정해줘야 한다. default가 false이다. 
  use_lt    = var.asg_use_lt    # launch template을 사용한다. 
  create_lt = var.asg_create_lt # launch template을 만든다.  

  image_id      = var.asg_ami      # 애플리케이션 서버의 ami 
  instance_type = var.asg_instance_type # 애플리케이션 서버 인스턴스 유형

  target_group_arns = module.alb.target_group_arns                                           # ALB arn
  security_groups   = [module.asg_sg.security_group_id, module.asg_ssh_sg.security_group_id] # ASG에 쓸 Security Group id
  key_name          = aws_key_pair.wordpress-app-shpark.key_name                    # 애플리케이션 keypair

  tags = var.asg_lt_tags # 태그
}