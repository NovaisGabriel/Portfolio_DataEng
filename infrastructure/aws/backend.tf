# Backend configuration require a AWS storage bucket.
terraform {
  backend "s3" {
    bucket = "teste-estrutura"
    key    = "state/terraform.tfstate"
    region = "us-east-2"
  }
}
