variable "aws_region" {
  description = "Região AWS onde os recursos serão criados"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Prefixo usado no nome dos recursos"
  type        = string
  default     = "ml-app"
}

variable "vpc_cidr" {
  description = "CIDR block da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR da subnet pública, usada apenas pelo NAT Gateway"
  type        = string
  default     = "10.0.0.0/24"
}

variable "private_subnet_python_cidr" {
  description = "CIDR da subnet da instância Python/ML (permanece privada, sem IP público)"
  type        = string
  default     = "10.0.10.0/24"
}

variable "private_subnet_java_cidr" {
  description = "CIDR da subnet da instância Java/Angular (recebe rota direta para o IGW, conforme pedido)"
  type        = string
  default     = "10.0.11.0/24"
}

variable "instance_type_python" {
  description = "Tipo da instância EC2 Python/ML"
  type        = string
  default     = "t3.medium"
}

variable "instance_type_java" {
  description = "Tipo da instância EC2 Java/Angular"
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "Nome do key pair EC2 usado para acesso SSH"
  type        = string
  default     = null
}

variable "python_app_port" {
  description = "Porta em que a aplicação Python expõe sua API para a instância Java"
  type        = number
  default     = 5000
}

variable "java_app_port" {
  description = "Porta em que o backend Java expõe a aplicação para o Usuário"
  type        = number
  default     = 8080
}

variable "ssh_port" {
  description = "Porta SSH para administração direta da instância Java/Angular"
  type        = number
  default     = 22
}

variable "allowed_user_cidrs" {
  description = "CIDRs autorizados a acessar a instância Java/Angular (app + SSH). Default aberto (0.0.0.0/0) conforme solicitado — restrinja em produção."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}