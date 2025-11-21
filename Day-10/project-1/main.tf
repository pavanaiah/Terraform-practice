provider "aws" {
    region = var.resource_values.region
  
}

resource "aws_vpc" "p1_vpc" {
    cidr_block =   var.resource_values.vpc_cidr

    tags = {
      Name = var.resource_values.vpc_name
    }
}

resource "aws_subnet" "p1_sub" {
count = length(var.resource_values.subnet_info.sub_cidr)

    vpc_id = aws_vpc.p1_vpc.id
    availability_zone = var.resource_values.subnet_info.sub_az[count.index]
    cidr_block = var.resource_values.subnet_info.sub_cidr[count.index]
    tags = {
      Name = var.resource_values.subnet_info.sub_name[count.index]
    }
}
