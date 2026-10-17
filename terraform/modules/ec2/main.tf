resource "aws_instance" "ec2-valkyrie" {
  ami           = "ami-0b6d9d3d33ba97d99"
  instance_type = "t2.large"
  tags = {
    Name = "ec2-valkyrie"
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 67
    volume_type = "gp3"
  }

  key_name = var.public_key_valkyrie

  vpc_security_group_ids = [var.sgp_pub_id]

  subnet_id = var.sub_pub_id
}