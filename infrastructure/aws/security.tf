# Security Group
resource "aws_security_group" "allow-all-traffic-vpn-ingress" {

  name = "tf_ingress"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# Security Group
resource "aws_security_group" "allow-all-traffic-vpn-egress" {

  name = "tf_egress"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}