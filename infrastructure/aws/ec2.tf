data "template_file" "init" {
  template = "./CI/scripts/startup.sh"
}

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "TFkey" {
  key_name   = "mykey" 
  public_key = tls_private_key.pk.public_key_openssh
}

resource "local_file" "ssh_key" {
  filename = "secretkey/${aws_key_pair.TFkey.key_name}.pem"
  content = tls_private_key.pk.private_key_pem
  file_permission = "0400" 
}

resource "aws_instance" "web" {
  ami           = "ami-0b4577d77dac11b84"
  instance_type = "t3.medium"
  key_name      = aws_key_pair.TFkey.key_name

  vpc_security_group_ids = [aws_security_group.allow-all-traffic-vpn-ingress.id, aws_security_group.allow-all-traffic-vpn-egress.id]

  associate_public_ip_address = true

  user_data = data.template_file.init.rendered

  tags = {
    Name = "newec2"
  }
}

resource "aws_eip" "public_ip" {
  instance = aws_instance.web.id
  vpc      = true
}

