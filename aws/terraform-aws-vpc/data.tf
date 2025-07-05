#Info about AZ's
data "aws_availability_zones" "available" {
  state = "available"
}

#Info about Default VPC
data "aws_vpc" "default" {
  default = true
  
}

#Info about Default VPC Routetable
data "aws_route_table" "main" {
  vpc_id = data.aws_vpc.default.id
  filter {
    name = "association.main"
    values = ["true"]
  }
}