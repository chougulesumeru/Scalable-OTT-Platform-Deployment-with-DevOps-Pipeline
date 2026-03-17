# configure output file

output "public_ip" {
  value = aws_instance.my-ec2.public_ip
}

output "public_dns" {
  value = aws_instance.my-ec2.public_dns
}

output "private_ip" {
  value = aws_instance.my-ec2.private_ip
}

output "private_dns" {
  value = aws_instance.my-ec2.private_dns
}
