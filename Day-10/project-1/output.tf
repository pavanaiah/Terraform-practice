output "vpc_id" {
    value = aws_vpc.p1_vpc.id
  
}
output "sub-1" {
    value =aws_subnet.p1_sub[*].id
  
}

