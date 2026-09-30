resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# Subnet pública — usada só para hospedar o NAT Gateway (saída de internet da
# instância Python, que continua 100% privada)
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-nat"
  }
}

# Subnet da instância Python/ML — permanece privada (sem rota direta ao IGW)
resource "aws_subnet" "private_python" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_python_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.project_name}-private-python"
  }
}

# Subnet da instância Java/Angular — recebe rota direta para o IGW e a
# instância ganha IP público, para reproduzir a seta "Usuário -> EC2" do
# diagrama sem ALB/VPN no meio. Isso remove o isolamento de subnet privada
# só para essa instância.
resource "aws_subnet" "java" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_java_cidr
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-java-exposed"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-nat-eip"
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "${var.project_name}-nat"
  }

  depends_on = [aws_internet_gateway.main]
}

# Route table pública — IGW direto. Usada pela subnet do NAT e pela subnet
# da instância Java (acesso direto do Usuário).
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "java" {
  subnet_id      = aws_subnet.java.id
  route_table_id = aws_route_table.public.id
}

# Route table privada — sai pelo NAT Gateway. Usada só pela subnet Python.
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "${var.project_name}-private-rt"
  }
}

resource "aws_route_table_association" "private_python" {
  subnet_id      = aws_subnet.private_python.id
  route_table_id = aws_route_table.private.id
}