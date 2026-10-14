resource "aws_security_group" "sgp_pub_valkyrie" {
  name        = "sgp_pub_valkyrie"
  description = "Allow SSH acess"
  vpc_id      = var.vpc_id

  // ENTRADA

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // SAÍDA

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sgp_pub_valkyrie"
  }
}