resource "aws_instance" "vault" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.vault.id]
  associate_public_ip_address = true

  user_data = var.user_data  # This line makes use of the user_data passed from the module
  
  tags = {
    Name = "Vault Host"
  }
}

resource "aws_security_group" "vault" {
  name_prefix = "vault-sg-"
  vpc_id      = var.vpc_id

  # Allow SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow access to Vault (port 8200)
  ingress {
    from_port   = 8200
    to_port     = 8200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Update with more restrictive CIDR if necessary
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
