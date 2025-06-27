
# vpc
resource "aws_vpc" "bayer_vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "bayer-vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.bayer_vpc.id
  cidr_block              = var.public_subnet_1_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.public_subnet_1_az
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.bayer_vpc.id
  cidr_block              = var.public_subnet_2_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.public_subnet_2_az
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.bayer_vpc.id
  cidr_block        = var.private_subnet_1_cidr_block
  availability_zone = var.private_subnet_1_az
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.bayer_vpc.id
  cidr_block        = var.private_subnet_2_cidr_block
  availability_zone = var.private_subnet_2_az
}

resource "aws_internet_gateway" "bayer_igw" {
  vpc_id = aws_vpc.bayer_vpc.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.bayer_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bayer_igw.id
  }
}

resource "aws_route_table_association" "public_route_association_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_association_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_eip" "nat_eip" {
  tags = {
    Name = "bayer-eip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.bayer_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
}

resource "aws_route_table_association" "private_route_table_association_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_route_association_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}
