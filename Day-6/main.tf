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

resource "aws_route_table_association" "r_sa"{
  count = length(var.resource_values.subnet-info.sub-cidr)

  subnet_id = aws_subnet.r_sub[count.index].id
  route_table_id = aws_route_table.r_rt.id
}

resource "aws_security_group" "r_sg" {
  vpc_id = aws_vpc.r_vpc.id
  name = "sg_terraform"
  description = "allowing ssh & http ports"

  ingress {
    to_port = 22
    from_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
ingress {
    to_port = 80
    from_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
egress {
  to_port = 0
  from_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
}

