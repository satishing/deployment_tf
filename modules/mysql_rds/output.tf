output "id" {
  description = "ID of db instances"
  value       = aws_db_instance.this.id
}

output "arn" {
  description = "ARN of db instances"
  value       = aws_db_instance.this.arn
}

output "endpoint" {
  description = "EP of db instances"
  value       = aws_db_instance.this.endpoint
}