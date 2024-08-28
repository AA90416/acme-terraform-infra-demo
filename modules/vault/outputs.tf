output "vault_public_ip" {
  description = "Public IP address of the bastion host."
  value       = aws_instance.vault.public_ip
}

output "security_group_id" {
  value = aws_security_group.vault.id
}
