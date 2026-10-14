output "ec2_ip" {
  value = "${aws_instance.ec2-valkyrie.private_ip}/32"
}
output "ec2_ip_publico" {
  value = "${aws_instance.ec2-valkyrie.public_ip}/32"
}
output "ec2_id" {
  value = aws_instance.ec2-valkyrie.id
}