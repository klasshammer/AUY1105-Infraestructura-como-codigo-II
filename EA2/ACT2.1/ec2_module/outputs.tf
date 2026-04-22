output "instance_id" {
  description = "ID de la instancia EC2"
  value       = aws_instance.mi_ec2.id
}

output "public_ip" {
  description = "IP pública de la instancia EC2"
  value       = aws_instance.mi_ec2.public_ip
}

output "security_group_id" {
  description = "ID del grupo de seguridad"
  value       = var.is_private ? aws_security_group.ssh_access_private.id : aws_security_group.ssh_access_public.id
}
