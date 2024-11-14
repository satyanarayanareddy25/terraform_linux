# outputs.tf
output "ec2_instance_public_ip" {
  value = aws_instance.web.public_ip
}
output "ec2_instance_private_ip" {
  value = aws_instance.web.private_ip
}