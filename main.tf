# main.tf



module "vpc" {
  source = "./modules/vpc"

  vpc_cidr              = var.vpc_cidr
  pub_sub1_cidr_block   = var.pub_sub1_cidr_block
  pub_sub2_cidr_block   = var.pub_sub2_cidr_block
  prv_sub1_cidr_block   = var.prv_sub1_cidr_block
  prv_sub2_cidr_block   = var.prv_sub2_cidr_block
  availability_zone_1   = var.availability_zone_1
  availability_zone_2   = var.availability_zone_2
  sg_name               = var.sg_name
  sg_description        = var.sg_description
  sg_tagname            = var.sg_tagname
  sg_ws_name            = var.sg_ws_name
  sg_ws_description     = var.sg_ws_description
  sg_ws_tagname         = var.sg_ws_tagname
}

resource "aws_launch_configuration" "webserver-launch-config" {
  name_prefix   = "webserver-launch-config"
  image_id      = var.web_ami
  instance_type = var.web_instance_type
  key_name      = var.key_name
  security_groups = [module.vpc.webserver_sg_id]

  root_block_device {
    volume_type = "gp2"
    volume_size = 20
    encrypted   = true
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = "gp2"
    volume_size = 5
    encrypted   = true
  }

  lifecycle {
    create_before_destroy = true
  }
  user_data = filebase64("${path.module}/instance_scripts/init_webserver.sh")
}

resource "aws_autoscaling_group" "Demo-ASG-tf" {
  name                    = "Demo-ASG-tf"
  desired_capacity        = 3
  max_size                = 6
  min_size                = 2
  force_delete            = true
  depends_on              = [aws_lb.ALB-tf]
  target_group_arns       = [aws_lb_target_group.TG-tf.arn]
  health_check_type       = "EC2"
  launch_configuration    = aws_launch_configuration.webserver-launch-config.name
  vpc_zone_identifier     = [module.vpc.prv_sub1_id, module.vpc.prv_sub2_id]
  service_linked_role_arn = var.service_linked_role_arn

  tag {
    key                 = "Name"
    value               = "Demo-ASG-tf"
    propagate_at_launch = true
  }
}

resource "aws_lb_target_group" "TG-tf" {
  name     = "Demo-TargetGroup-tf"
  depends_on = [module.vpc.vpc_id]
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
  health_check {
    interval            = 70
    path                = "/index.html"
    port                = 80
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 60
    protocol            = "HTTP"
    matcher             = "200,202"
  }
}

resource "aws_lb" "ALB-tf" {
  name              = "Demo-ALG-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.vpc.elb_sg_id]
  subnets            = [module.vpc.pub_sub1_id, module.vpc.pub_sub2_id]

  tags = {
    name    = "Demo-AppLoadBalancer-tf"
    Project = "demo-assignment"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.ALB-tf.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG-tf.arn
  }
}

data "aws_lb" "ALB" {
  name = aws_lb.ALB-tf.name
}

# Creates a bastion host on subnet 1

module "bastion" {
  source        = "./modules/bastion"
  count         = var.deploy_bastion ? 1 : 0
  subnet_id     = module.vpc.pub_sub1_id
  bastion_ami           = var.bastion_ami
  bastion_instance_type  = var.bastion_instance_type
  key_name      = var.key_name
  vpc_id        = module.vpc.vpc_id
}

# Creates a host on subnet 2 with Vault Installed

module "vault" {
  source        = "./modules/vault"
  count         = var.deploy_vault ? 1 : 0
  subnet_id     = module.vpc.pub_sub2_id
  ami           = var.vault_ami
  instance_type = var.vault_instance_type
  key_name      = var.key_name 
  vpc_id        = module.vpc.vpc_id#

  user_data = filebase64("${path.module}/instance_scripts/vault_install.sh")
}


# Creates an S3 bucket with lifecycle rules

module "s3" {
  source          = "./modules/s3"
  bucket_name     = var.bucket_name
  lifecycle_rules = [
    {
      id      = "images_rule"
      prefix  = "Images/"
      status  = "Enabled"
      transition = {
        days          = 90
        storage_class = "GLACIER"
      }
    },
    {
      id      = "logs_rule"
      prefix  = "Logs/"
      status  = "Enabled"
      expiration = {
        days = 90
      }
    }
  ]
}
