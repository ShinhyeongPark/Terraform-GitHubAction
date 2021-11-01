
output "bastion_ec2_id" {
  description = "Bastion Instane ID"
  value       = module.bastion_ec2.id
}

output "bastion_ec2_arn" {
  description = "The ARN of the instance"
  value       = module.bastion_ec2.arn
}

output "bastion_ec2_capacity_reservation_specification" {
  description = "Capacity reservation specification of the instance"
  value       = module.bastion_ec2.capacity_reservation_specification
}

output "bastion_ec2_instance_state" {
  description = "The state of the instance. One of: `pending`, `running`, `shutting-down`, `terminated`, `stopping`, `stopped`"
  value       = module.bastion_ec2.instance_state
}

output "bastion_ec2_primary_network_interface_id" {
  description = "The ID of the instance's primary network interface"
  value       = module.bastion_ec2.primary_network_interface_id
}

output "bastion_ec2_private_dns" {
  description = "The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  value       = module.bastion_ec2.private_dns
}

output "bastion_ec2_public_dns" {
  description = "The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  value       = module.bastion_ec2.public_dns
}

output "bastion_ec2_public_ip" {
  description = "The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached"
  value       = module.bastion_ec2.public_ip
}

output "bastion_ec2_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block"
  value       = module.bastion_ec2.tags_all
}