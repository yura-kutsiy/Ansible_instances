output "public_master_ip" {
  value = aws_instance.master.public_ip
}
output "public_client_x_ip" {
  value = aws_instance.x.public_ip
}
output "public_client" {
  value = aws_instance.client1.*.public_ip
}

output "private_master_ip_" {
  value = aws_instance.master.private_ip
}
output "private_client_x_ip" {
  value = aws_instance.x.private_ip
}
output "private_client_" {
  value = aws_instance.client1.*.private_ip
}
