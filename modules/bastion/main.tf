resource "aws_instance" "bastion" {
  ami           = var.bastion_ami
  instance_type = var.bastion_instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.bastion.id] 
  tags = {
    Name = "Bastion Host"
  }
}


resource "aws_security_group" "bastion" {
  name_prefix = "bastion-sg-"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
