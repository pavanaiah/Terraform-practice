resource "aws_vpc" "r_vpc" {
    cidr_block = var.resource_values.vpc-cidr
    tags = {
      Name = var.resource_values.vpc-name
    }
  
}

resource "aws_subnet" "r_sub" {
    vpc_id = aws_vpc.r_vpc.id

    count = length(var.resource_values.subnet-info.sub-cidr)

    availability_zone = var.resource_values.subnet-info.sub-az[count.index]
    cidr_block = var.resource_values.subnet-info.sub-cidr[count.index]
    tags = {
      Name= var.resource_values.subnet-info.sub-name[count.index]
    }

}

resource "aws_internet_gateway" "r_igw" {
  vpc_id = aws_vpc.r_vpc.id
  tags = {
    Name = "igw-terraform"
  }
  
}

resource "aws_route_table" "r_rt" {
  vpc_id = aws_vpc.r_vpc.id
  tags = {
    Name = "rt-terraform"
  }
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.r_igw.id
  }
}

resource "aws_route_table_association" "name"{
  count = length(var.resource_values.subnet-info.sub-cidr)

  subnet_id = aws_subnet.r_sub[count.index].id
  route_table_id = aws_route_table.r_rt.id
}
