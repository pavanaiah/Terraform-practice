output "vpc_id" {
value  = aws_vpc.vpc-v1.id

}

output "aws_subnet" {
  value = aws_subnet.sub_v[0].id
}