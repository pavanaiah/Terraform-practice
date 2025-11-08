resource "aws_vpc" "r_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name= "1st-vpc"
    }
}


resource "aws_subnet" "r_sub1" {
    vpc_id = aws_vpc.r_vpc.id
    availability_zone = "ap-south-1a"
    cidr_block = "10.0.0.0/24"
    tags = {
      Name= "sub-1"
    }
  
}
