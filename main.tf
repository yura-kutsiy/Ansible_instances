provider "aws" {
  region = "eu-central-1"
}
#-----------------------------------------------------------------------
data "aws_ami" "ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "aws_ami" "redhat" {
  owners      = ["309956199498"]
  most_recent = true
  filter {
    name   = "name"
    values = ["RHEL_HA-8.4.0_HVM-20210504-x86_64-*"]
  }
}
#-----------------------------------------------------------------------
data "aws_availability_zones" "available" {}

resource "aws_default_subnet" "def_subnet_1" {
  availability_zone = data.aws_availability_zones.available.names[0]
}

#-----------------------------------------------------------------------
variable "instance_type" {
  default = "t2.micro"
}
variable "instance_count" {
  default = "2"
}
#-----------------------------------------------------------------------
resource "aws_instance" "master" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  key_name                    = "master"
  security_groups             = [aws_security_group.main.id]
  subnet_id                   = aws_default_subnet.def_subnet_1.id
  user_data                   = file("./scripts/startAnsible.sh")
  tags                        = { Name = "Ansible-Master" }

  provisioner "file" {
    source      = "~/DevOps/Ansible/keys/"
    destination = "~/.ssh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("../keys/master.pem")
      host        = aws_instance.master.public_ip
    }
  }
}

resource "aws_instance" "x" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  key_name                    = "client-x"
  security_groups             = [aws_security_group.main.id]
  subnet_id                   = aws_default_subnet.def_subnet_1.id
  user_data                   = file("./scripts/update_server.sh")
  tags = {
    Name = "Ansible-Client-X"
  }
}

resource "aws_instance" "client1" {
  count                       = var.instance_count
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  key_name                    = "client-1"
  security_groups             = [aws_security_group.main.id]
  subnet_id                   = aws_default_subnet.def_subnet_1.id
  user_data                   = file("./scripts/update_server.sh")
  tags = {
    Name = "Ansible-Client-${count.index + 1}"
  }
}
#-----------------------------------------------------------------------
