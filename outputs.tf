output "load_balancer_dns" {
  value = data.aws_lb.ALB.dns_name
}

output "vault_public_ip" {
  value       = var.deploy_vault ? module.vault[0].vault_public_ip : null
  description = "The public IP of the Vault instance."
}

output "bastion_public_ip" {
  value       = var.deploy_bastion ? module.bastion[0].bastion_public_ip : null
  description = "The public IP of the Bastion host."
}