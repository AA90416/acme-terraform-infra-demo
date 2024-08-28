output "vault_public_ip" {
  value = module.vault.vault_public_ip
}

output "load_balancer_dns" {
  value = data.aws_lb.ALB.dns_name
}

output "bastion_public_ip" {
  value = module.bastion.bastion_public_ip
}
