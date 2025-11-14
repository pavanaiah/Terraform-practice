data "aws_vpc" "p2_vpc" {
  id = "vpc-00d6b680ce42ba4cf"
}

data "aws_subnet" "p2_sub" {
  vpc_id = local.vpcid


  filter {
    name = "tag:Name"
    values = ["p1-sub-1"]
  }
  filter {
  name =  "cidr"
  values = ["10.0.0.0/24"]
  }

}


resource "aws_subnet" "p2_sub-new" {
  vpc_id = local.vpcid
  availability_zone = local.az
  cidr_block = "10.0.10.0/24"
  tags = {
    Name = "p2-sub1"
  }
}
resource "aws_internet_gateway" "p2_igw" {
  vpc_id = local.vpcid
  tags = {
    Name = "p2_igw"
  }
  
}