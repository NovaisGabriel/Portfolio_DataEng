data "template_file" "init" {
  template = "./CI/scripts/startup.sh"
}

# resource "tls_private_key" "pk" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "aws_key_pair" "kp" {
#   key_name   = "public-key" 
#   public_key = tls_private_key.pk.public_key_openssh

#   provisioner "local-exec" {
#     command = "echo '${tls_private_key.pk.private_key_pem}' > ./public-key.pem"
#   }
# }

# https://cloud-images.ubuntu.com/locator/ec2/
resource "aws_instance" "airflow-iac" {
  ami           = "ami-0b4577d77dac11b84"
  instance_type = "t3.medium"
  # key_name      = aws_key_pair.kp.key_name
  key_name = "public-key"

  vpc_security_group_ids = [aws_security_group.allow-all-traffic-vpn-ingress.id, aws_security_group.allow-all-traffic-vpn-egress.id] 

  associate_public_ip_address = true

  user_data = "${data.template_file.init.rendered}"

  tags = {
      Name = "airflow-iac"
  } 
}

resource "aws_eip" "public_ip" {
  instance = aws_instance.airflow-iac.id
  vpc      = true
}

