resource "aws_vpc" "vpc-valkyrie" {
  cidr_block = "10.0.0.0/24"

  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = {
    Name = "vpc-valkyrie"
  }
}
resource "aws_subnet" "sub-pub-valkyrie" {
  vpc_id            = aws_vpc.vpc-valkyrie.id
  cidr_block        = "10.0.0.0/26"
  availability_zone = "us-east-1a"
  tags = {
    Name = "sub-pub-valkyrie"
  }
  enable_resource_name_dns_a_record_on_launch = true
  map_public_ip_on_launch                     = true
}
resource "aws_internet_gateway" "igw-valkyrie" {
  vpc_id = aws_vpc.vpc-valkyrie.id

  tags = {
    Name = "valkyrie-igw"
  }
}
