

resource "aws_vpc" "vpc" {
  cidr_block           = format("10.%d.0.0/16", var.vpc_octet)
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = merge(var.env_tags, {
    Name = var.vpc_name
  })
}

# Subnets
resource "aws_subnet" "public" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.availability_zones[count.index]
  cidr_block        = format("10.%s.%s.0/24", var.vpc_octet, 10 * count.index)

  tags = merge(var.env_tags, {
    Name = format("%s-%s", "Public", var.availability_zones[count.index])
  })
}

resource "aws_subnet" "private" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.availability_zones[count.index]
  cidr_block        = format("10.%d.%d.0/24", var.vpc_octet, 1 + (10 * count.index))

  tags = merge(var.env_tags, {
    Name = format("%s-%s", "Private", var.availability_zones[count.index])
  })
}

#igw
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(var.env_tags, {
    Name = format("igw%s", var.vpc_name)
  })
}
#ngw, only one will do
resource "aws_eip" "ngw_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "ngw" {
  subnet_id         = aws_subnet.public[0].id
  allocation_id     = aws_eip.ngw_eip.id
  connectivity_type = "public"

  tags = merge(var.env_tags, {
    Name = format("ngw%s", var.vpc_name)
  })
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(var.env_tags, {
    Name = "Private"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(var.env_tags, {
    Name = "Public"
  })
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "nat_internet" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw.id

}

resource "aws_route53_zone" "private" {
  name = format("%s.bab", var.vpc_name)
  vpc {
    vpc_id = aws_vpc.vpc.id
  }

  tags = merge(var.env_tags, {
    Name = "Private"
  })
}