variable "bastion_keypair" {
    default = "secret"
}

variable "bastion_sg_name" {
    default = "bastion-sg-shpark"
}

variable "bastion_sg_tag" {
    default = {
        Name = "bastion-sg-shpark" 
    }
}

variable "bastion_name" {
    default = "bastion-shpark"
}

variable "bastion_ami" {
    default = "ami-03d5c68bab01f3496"
}

variable "bastion_instance_type" {
    default = "t2.nano"
}

variable "bastion_private_ip" {
    default = "10.80.11.11"
}

variable "bastion_tags" {
    default = {
        Name = "bastion-shpark"
    }
}