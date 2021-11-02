variable "db_keypair" {
    default = "secret"
}

variable "db_sg_name" {
    default = "db-sg-shpark"
}

variable "db_sg_cidr_blocks" {
    default = [
        "10.80.21.0/24",
        "10.80.22.0/24"
    ]
}

variable "db_sg_tags" {
    default = {
        Name = "db-sg-shpark"
    }
}

variable "db_ssh_sg_name" {
    default = "db-ssh-sg-shpark"
}


variable "db_ssh_sg_cidr_blocks" {
    default = [
        "10.80.11.11/32",
        "10.80.21.0/24",
        "10.80.22.0/24"
    ]
}

variable "db_ssh_sg_tags" {
    default = {
        Name = "db-ssh-sg-shpark"
    }
}

variable "db_name" {
    default = "db-shpark"
}

variable "db_ami" {
    default = "ami-03d5c68bab01f3496"
}

variable "db_instance_type" {
    default = "t2.micro"
}

variable "db_private_ip" {
    default = "10.80.31.31"
}

variable "db_tags" {
    default = {
        Name = "db-shpark"
    }
}