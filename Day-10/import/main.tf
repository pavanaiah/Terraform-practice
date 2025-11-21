resource "aws_vpc" "code_vpc" {
  
   cidr_block = "20.0.0.0/16"

  tags = {
    Name = "my-app"
  }
}

 resource "aws_subnet" "code_sub1" {
   vpc_id = aws_vpc.code_vpc.id
 cidr_block = "20.0.1.0/24"
   }

 resource "aws_subnet" "code_sub2" {
   vpc_id = aws_vpc.code_vpc.id
  cidr_block = "20.0.2.0/24"
 }