output "vpc_id" {
  value = aws_vpc.vpc-valkyrie.id
}
output "sub_pub_id" {
  value = aws_subnet.sub-pub-valkyrie.id
}
output "igw_id" {
  value = aws_internet_gateway.igw-valkyrie.id
}
