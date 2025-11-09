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

