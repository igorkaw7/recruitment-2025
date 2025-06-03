resource "aws_key_pair" "admin1_ssh_key" {
  key_name   = var.admin1_ssh_key_name
  public_key = file(var.admin1_ssh_key_path)
}

resource "aws_instance" "weatherapp" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  key_name               = aws_key_pair.admin1_ssh_key.key_name

  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  tags = {
    Name = var.instance_name
  }
}
