# #############################################################
# #              [EC2 Instance]
# #############################################################
# #Instance [Bastion, App]
# resource "aws_instance" "bastion_server" {
#     ami = "ami-03d5c68bab01f3496" #Ubuntu Server 20.04 LTS AMI
#     instance_type = "t2.micro"
#     vpc_security_group_ids = [ "${aws_security_group.bastion_server.id}" ]
# }

# resource "aws_instance" "app_server" {
#     ami = "ami-03d5c68bab01f3496" #Ubuntu Server 20.04 LTS AMI
#     instance_type = "t2.micro"
#     vpc_security_group_ids = [ "${aws_security_group.app_server.id}" ]
# }
