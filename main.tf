/*==== The VPC ======*/
resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = "${var.environment}-vpc"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.subnet1_cidr}"
  availability_zone = "${var.availability_zones}"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.environment}-${var.availability_zones}-subnet1"
    }
  }

  resource "aws_subnet" "pvtsubnet1" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.pvtsubnet1_cidr}"
  availability_zone = "${var.availability_zones}"
  tags = {
    Name = "${var.environment}-${var.availability_zones}-subnet1"
    }
  }

  resource "aws_route_table" "public" {
     vpc_id = "${aws_vpc.vpc.id}"
     tags = {
    Name = "${var.environment}-pub"
    }
}

resource "aws_route_table" "private" {
     vpc_id = "${aws_vpc.vpc.id}"
     tags = {
       Name = "${var.environment}-pri"
    }
}

resource "aws_route_table_association" "public_subnet_1" {
    subnet_id      = aws_subnet.subnet1.id
    route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "private_subnet_1" {
    subnet_id      = aws_subnet.pvtsubnet1.id
    route_table_id = aws_route_table.private.id
}
/*==== Subnets ======*/
/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "ig" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name        = "${var.environment}-igw"
    Environment = "${var.environment}"
  }
}
/* Elastic IP for NAT */
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.ig]
}

resource "aws_nat_gateway" "ngw" {
    subnet_id     = aws_subnet.subnet1.id
    allocation_id = aws_eip.nat_eip.id

    depends_on = [aws_internet_gateway.ig]
}
