variable "app_keypair" {
    default = "secret"
}
#Application Load Balancer Security Group
variable "alb_http_sg_name" {
    default = "alb-http-sg-shpark"
}

variable "alb_http_sg_tags" {
    default = {
        Name = "alb-http-sg-shpark"
    }
}
# Auto Scaling Group
variable "asg_ssh_sg_name" {
    default = "ags-ssh-sg-shpark"
}

variable "asg_ssh_sg_tags" {
    default = {
        Name = "asg-ssh-sg-shpark"
    }
}

variable "asg_ssh_sg_cidr_blocks" {
    default = ["10.80.11.11/32"]
}

variable "asg_sg_name" {
    default = "asg-sg-shpark"
}

variable "asg_sg_tags" {
    default = {
        Name = "asg-sg-shpark"
    }
}

variable "alb_name" {
    default = "alb-shpark"
}

variable "alb_tag_name" {
    default = "alb-tag-shpark"
}

variable "alb_tags" {
    default = {
        Name = "alb-shpark"
    }
}

variable "asg_lt_name" {
    default = "asg-lt-shpark"
}

variable "asg_min_size" {
    default = 0
}

variable "asg_max_size" {
    default = 1
}

variable "asg_desired_capacity" {
    default = 1
}

variable "asg_use_lt" {
    default = true
}

variable "asg_create_lt" {
    default = true
}

variable "asg_ami" {
  default = "ami-03d5c68bab01f3496"
}

variable "asg_instance_type" {
  default = "t2.micro"
}

variable "asg_lt_tags" {
    default = [{
        Name = "asg-lt-shpark"
    }]
}