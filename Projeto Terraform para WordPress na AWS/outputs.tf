output "instance_public_ip" {
  description = "IP público da instância EC2"
  value       = aws_instance.wordpress.public_ip
}

output "instance_id" {
  description = "ID da instância EC2 criada"
  value       = aws_instance.wordpress.id
}