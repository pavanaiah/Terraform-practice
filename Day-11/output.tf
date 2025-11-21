output "vpc_id" {
value  = aws_vpc.r_vpc.id

}

output "aws_subnet" {
  value = aws_subnet.r_sub[0].id
}