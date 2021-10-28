variable "bastion-rt-subnet" {
    default = [
        aws_subnet.subnet-bastion-1a,
        aws_subnet.subnet-bastion-1b
    ]
}

variable "webapp-rt-subnet" {
    default = [
        aws_subnet.subnet-webapp-1a,
        aws_subnet.subnet-webapp-1b
    ]
}

variable "webapp-rds-subnet" {
    default = [
        aws_subnet.subnet-rds-1a,
        aws_subnet.subnet-rds-1b
    ]
}
