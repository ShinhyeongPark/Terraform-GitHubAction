#############################################################
#              [Security Group-Bastion Server]
#############################################################
resource "aws_security_group" "bastion_server" {
    name = "allow_to_bastion_server"
    description = "Inbound Rule Bastion Server"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["211.168.91.10/32"] # My IP
    }
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["10.80.21.0/24"] # My IP
    }
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["10.80.22.0/24"] # My IP
    }
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["10.80.23.0/24"] # My IP
    }
}
#############################################################
#              [Security Group-App Server]
#############################################################
resource "aws_security_group" "app_server" {
    name = "allow_to_app_server"
    description = "Inbound Rule App Server"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["211.168.91.10/32"] # My IP
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["10.80.11.0/24"] # My IP
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # My IP
    }
}
