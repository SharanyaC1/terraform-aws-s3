# Public Subnets
resource "aws_subnet" "public" {
  count = 3

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.subnet_newbits, count.index)
  availability_zone = local.azs[count.index]

  tags = {
    Name = "public-subnet-${count.index}"
  }
}

# Private Subnets
resource "aws_subnet" "private" {
  count = 3

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.subnet_newbits, count.index + 3)
  availability_zone = local.azs[count.index]

  tags = {
    Name = "private-subnet-${count.index}"
  }
}
#Internet Gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

#Nat Gateway

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
}


# Public Route Table

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

#association

resource "aws_route_table_association" "public" {
  count = 3

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

