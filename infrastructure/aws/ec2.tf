data "template_file" "init" {
  template = "./CI/scripts/startup.sh"
}

resource "aws_instance" "airflow-iac" {
  ami           = "ami-0ed9277fb7eb570c9"
  instance_type = "t3.medium"
  key_name = "airflow-iac2"

  vpc_security_group_ids = [aws_security_group.allow-all-traffic-vpn-ingress.id, aws_security_group.allow-all-traffic-vpn-egress.id] 

  associate_public_ip_address = true

  user_data = "${data.template_file.init.rendered}"

  tags = {
      Name = "Aiflow-Iac"
  } 
}

resource "aws_eip" "public_ip" {
  instance = aws_instance.airflow-iac.id
  vpc      = true
}

