#-----------------------------------------------------------------------
resource "aws_security_group" "main" {
  #name        = "allow-ssh"
  description = "allow ssh conection"
  vpc_id      = aws_default_subnet.def_subnet_1.vpc_id
  #vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "SSH-HTTP-for-Ansible"
  }
}
#-----------------------------------------------------------------------
