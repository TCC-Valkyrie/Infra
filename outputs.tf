output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnet_python_id" {
  value = aws_subnet.private_python.id
}

output "java_subnet_id" {
  value = aws_subnet.java.id
}

output "python_ec2_private_ip" {
  value = aws_instance.python_ec2.private_ip
}

output "java_ec2_public_ip" {
  description = "IP publico usado pelo Usuario para acessar a aplicacao e via SSH"
  value       = aws_instance.java_ec2.public_ip
}

output "s3_bucket_modelos" {
  value = aws_s3_bucket.modelos.bucket
}

output "s3_bucket_client" {
  value = aws_s3_bucket.client.bucket
}

output "s3_bucket_trusted" {
  value = aws_s3_bucket.trusted.bucket
}

output "s3_bucket_raw" {
  value = aws_s3_bucket.raw.bucket
}