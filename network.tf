# resource "aws_vpc" "main" {
#   cidr_block = "10.0.0.0/16"
#   tags = {
#     Name = "Ansible-VPC"
#   }
# }
#
# resource "aws_subnet" "public" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = "10.0.1.0/24"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "public-Ansible"
#   }
# }
#
# resource "aws_internet_gateway" "main" {
#   vpc_id = aws_vpc.main.id
#   tags = {
#     Name = "main-ig-Ansible"
#   }
# }
#
# resource "aws_route_table" "public_subnet" {
#   vpc_id = aws_vpc.main.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.main.id
#   }
#   tags = {
#     Name = "route-public-subnet-Ansible"
#   }
# }
#
# resource "aws_route_table_association" "public_route" {
#   route_table_id = aws_route_table.public_subnet.id
#   subnet_id      = aws_subnet.public.id
# }
