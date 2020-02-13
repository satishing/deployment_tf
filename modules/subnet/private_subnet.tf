resource "aws_subnet" "priv_subnets" {
  vpc_id            = var.vpc_id
  count             = length(var.zones)
  cidr_block        = cidrsubnet(var.cidr, var.subnet_bits_default, count.index + (var.priv_subnet_start * length(var.zones)))
  availability_zone = var.zones[count.index]

  tags = merge(
    map(
      "Name", "${var.priv_name}-subnet-${count.index}",
    ),var.tags
  )  

  lifecycle {
    create_before_destroy = true
  }
}