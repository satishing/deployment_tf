resource "aws_security_group" "db_sg" {
  name   = "${var.name}-db-sg"
  vpc_id = var.vpc_id

  tags = merge(
    map(
      "Name", "${var.name}-db-sg",
    ),var.tags
  )

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [
		"0.0.0.0/0",
	]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}