output "web_sg_id" {
  value = aws_security_group.web_ssh.id
}

output "key_name" {
  value = aws_key_pair.deployer.key_name
}
