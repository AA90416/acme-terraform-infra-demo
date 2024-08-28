#!/bin/bash

# Update package list and install necessary utilities
sudo yum update -y
sudo yum install -y unzip curl firewalld

# Download and install Vault
VAULT_VERSION="1.11.3"
curl -O https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip
unzip vault_${VAULT_VERSION}_linux_amd64.zip
sudo mv vault /usr/local/bin/
sudo chmod +x /usr/local/bin/vault

# Create Vault directories
sudo mkdir --parents /etc/vault.d
sudo mkdir /opt/vault

# Create Vault configuration file
cat <<EOF | sudo tee /etc/vault.d/vault.hcl
storage "file" {
  path = "/opt/vault/data"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = true
}

ui = true
EOF

# Create a systemd service file for Vault
cat <<EOF | sudo tee /etc/systemd/system/vault.service
[Unit]
Description="HashiCorp Vault - A tool for managing secrets"
Documentation=https://www.vaultproject.io/
After=network.target

[Service]
ExecStart=/usr/local/bin/vault server -config=/etc/vault.d/vault.hcl
ExecReload=/bin/kill --signal HUP \$MAINPID
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd, enable, and start Vault service
sudo systemctl daemon-reload
sudo systemctl enable vault
sudo systemctl start vault

# Enable and start firewalld service
sudo systemctl enable firewalld
sudo systemctl start firewalld

# Allow Vault traffic on port 8200 through the firewall
sudo firewall-cmd --permanent --add-port=8200/tcp
sudo firewall-cmd --reload

# Check Vault service status
sudo systemctl status vault
