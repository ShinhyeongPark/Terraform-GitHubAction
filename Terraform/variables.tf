variable "bastion-rt-subnet" {
    default = [
        "10.80.11.0/24",
        "10.80.12.0/24"
    ]
}

variable "webapp-rt-subnet" {
    default = [
        "10.80.21.0/24",
        "10.80.22.0/24"
    ]
}

variable "rds-rt-subnet" {
    default = [
        "10.80.31.0/24",
        "10.80.32.0/24"
    ]
}
