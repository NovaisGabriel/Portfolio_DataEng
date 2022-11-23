# Portfolio_DataEng
Repositório destinado a apresentar um projeto de provisionamento e orquestração de dados para cloud AWS.

criar chave terraform terraform-keys2:
ssh-keygen -f terraform-keys2

resource "aws_key_pair" "terraform-keys2" {
  key_name = "terraform-keys2"
  public_key = "terraform-keys2.pub"
}