#--------------------------------------------------------------------------------------
# Create vpc
#--------------------------------------------------------------------------------------
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    name = var.app_name
    env  = var.env
  }
}

#--------------------------------------------------------------------------------------
# Create Internet Gateway and attach it to VPC
#--------------------------------------------------------------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    name = var.app_name
    env  = var.env
  }
}

#--------------------------------------------------------------------------------------
# Create Public Subnets
#--------------------------------------------------------------------------------------
resource "aws_subnet" "public_subnet_one" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_one_cidr

  tags = {
    name = var.app_name
    env  = var.env
  }
}

resource "aws_subnet" "public_subnet_two" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_two_cidr

  tags = {
    name = var.app_name
    env  = var.env
  }
}


#--------------------------------------------------------------------------------------
# Create Private Subnets
#--------------------------------------------------------------------------------------
resource "aws_subnet" "private_subnet_one" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnet_one_cidr

  tags = {
    name = var.app_name
    env  = var.env
  }
}

resource "aws_subnet" "private_subnet_two" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnet_two_cidr

  tags = {
    name = var.app_name
    env  = var.env
  }
}


#--------------------------------------------------------------------------------------
# Route table for Public Subnet's
#--------------------------------------------------------------------------------------
resource "aws_route_table" "public_subnet_one_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    name = var.app_name
    env  = var.env
  }
}

resource "aws_route_table" "public_subnet_two_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    name = var.app_name
    env  = var.env
  }
}

#--------------------------------------------------------------------------------------
# Route table for Private Subnet's
#--------------------------------------------------------------------------------------
resource "aws_route_table" "private_subnet_one_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_one.id
  }

  tags = {
    name = var.app_name
    env  = var.env
  }
}

resource "aws_route_table" "private_subnet_two_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_two.id
  }

  tags = {
    name = var.app_name
    env  = var.env
  }
}

#--------------------------------------------------------------------------------------
# Route table Association with Public Subnet's
#--------------------------------------------------------------------------------------
resource "aws_route_table_association" "public_subnet_one_rt_association" {
  subnet_id      = aws_subnet.public_subnet_one.id
  route_table_id = aws_route_table.public_subnet_one_rt.id
}

resource "aws_route_table_association" "public_subnet_two_rt_association" {
  subnet_id      = aws_subnet.public_subnet_two.id
  route_table_id = aws_route_table.public_subnet_two_rt.id
}

#--------------------------------------------------------------------------------------
# Route table Association with Private Subnet's
#--------------------------------------------------------------------------------------
resource "aws_route_table_association" "private_subnet_one_rt_association" {
  subnet_id      = aws_subnet.private_subnet_one.id
  route_table_id = aws_route_table.private_subnet_one_rt.id
}

resource "aws_route_table_association" "private_subnet_two_rt_association" {
  subnet_id      = aws_subnet.private_subnet_two.id
  route_table_id = aws_route_table.private_subnet_two_rt.id
}

#--------------------------------------------------------------------------------------
# Create eip for vpc
#--------------------------------------------------------------------------------------
resource "aws_eip" "eip_one" {
  vpc = true

  tags = {
    name = var.app_name
    env  = var.env
  }
}

resource "aws_eip" "eip_two" {
  vpc = true

  tags = {
    name = var.app_name
    env  = var.env
  }
}

#--------------------------------------------------------------------------------------
# Creating the NAT Gateway using subnet_id and allocation_id
#--------------------------------------------------------------------------------------
resource "aws_nat_gateway" "nat_gw_one" {
  allocation_id = aws_eip.eip_one.id
  subnet_id     = aws_subnet.public_subnet_one.id

  tags = {
    name = var.app_name
    env  = var.env
  }
}

resource "aws_nat_gateway" "nat_gw_two" {
  allocation_id = aws_eip.eip_two.id
  subnet_id     = aws_subnet.public_subnet_two.id

  tags = {
    name = var.app_name
    env  = var.env
  }
}
