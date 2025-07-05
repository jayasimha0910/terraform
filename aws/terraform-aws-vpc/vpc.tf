#Create VPC
resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = merge(
    var.vpc_tags,
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}"
    }
  )
}


#create IGW
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id #accosiation with vpc

  tags = merge(
    var.igw_tags,
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}"
    }
  )
}


#create public-subnet
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[count.index]

  //availability_zone = slice(data.aws_availability_zones.available.names, 0,2)[count.index]
  availability_zone = local.az_names[count.index]
  map_public_ip_on_launch = true


  tags = merge(
    var.public_subnet_tags,
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-public-${local.az_names[count.index]}"
    }
  )
}


#create private-subnet
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidrs[count.index]

  availability_zone = local.az_names[count.index]
  //map_public_ip_on_launch = false //by default it will be false


  tags = merge(
    var.private_subnet_tags,
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-private-${local.az_names[count.index]}"
    }
  )
}


#Create database-subnet
resource "aws_subnet" "database" {
  count = length(var.database_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet_cidrs[count.index]

  availability_zone = local.az_names[count.index]
  

  tags = merge(
    var.database_subnet_tags,
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-database-${local.az_names[count.index]}"
    }
  )
}

#Create EIP 
resource "aws_eip" "nat" {
  domain   = "vpc"

  tags = merge(
    var.eip_tags,
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}"
    }
  )
}


#create NAT gateway on public subnet-1a and link to internet gateway
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    var.nat_tags,
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}"
    }
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]
}


#create public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.public_route_table_tags,
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-public"
    }
  )
}


#create private route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.private_route_table_tags,
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-private"
    }
  )
}


#create database route table
resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.database_route_table_tags,
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-database"
    }
  )
}


#Add internet route to public subnet through internet gateway
resource "aws_route" "public" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
}

#Add internet route to private subnet through NAT gateway
resource "aws_route" "private" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.main.id
}

#Add internet route to database subnet through NAT gateway
resource "aws_route" "database" {
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.main.id
}

#Public Route table association 
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

#Private Route table association 
resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

#Database Route table association 
resource "aws_route_table_association" "database" {
  count = length(var.database_subnet_cidrs)
  subnet_id      = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.database.id
}

