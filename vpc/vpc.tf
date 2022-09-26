# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_main_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.deployment}-vpc-main"
    Environment = var.environment
  }
}

# Private subnet(s)
resource "aws_subnet" "private" {
  count             = var.subnet_private_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.subnet_private_cidr_blocks, count.index)
  availability_zone = element(var.subnet_private_availability_zones, count.index)

  tags = {
    Name        = "${var.deployment}-subnet-private"
    Environment = var.environment
  }
}

# Route table and subnet(s) associations
resource "aws_route_table_association" "main" {
  count          = var.subnet_private_count
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_vpc.main.default_route_table_id
}
