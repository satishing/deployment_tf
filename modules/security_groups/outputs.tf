output "sg_id" {
    description = "The ID of the security group"
    value       = aws_security_group.nginx_sg.id
}

output "db_sg_id" {
    description = "The ID of the security group"
    value       = aws_security_group.db_sg.id
}