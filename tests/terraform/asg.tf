resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = "echo baz"
  }
}

module "public_asg" {
  source                      = "../../"
  name                        = "awspec-testing-public"
  envname                     = "foo"
  service                     = "bar"
  subnets                     = module.vpc.public_subnet_ids
  security_groups             = [aws_security_group.allow_all.id]
  ami_id                      = "ami-a85165db"
  associate_public_ip_address = true
  user_data                   = data.template_cloudinit_config.config.rendered
}

module "private_asg" {
  source                      = "../../"
  name                        = "awspec-testing-private"
  envname                     = "foo"
  service                     = "bar"
  subnets                     = module.vpc.private_subnet_ids
  security_groups             = [aws_security_group.allow_all.id]
  ami_id                      = "ami-a85165db"
  associate_public_ip_address = false
  min                         = 1
  max                         = 3
  autoscaling                 = true
  cpu_scale_up                = "50"
  cpu_scale_down              = "20"
  user_data                   = data.template_cloudinit_config.config.rendered
}

module "private_asg_tracked_scaling" {
  source                      = "../../"
  name                        = "awspec-testing-tracked-private"
  envname                     = "foo"
  service                     = "bar"
  subnets                     = module.vpc.private_subnet_ids
  security_groups             = [aws_security_group.allow_all.id]
  ami_id                      = "ami-a85165db"
  associate_public_ip_address = false
  min                         = 1
  max                         = 3
  autoscaling                 = true
  scaling_policy_type         = "TargetTrackingScaling"
  target_tracking_target_cpu  = "60"
  warmup_seconds              = "30"
  user_data                   = data.template_cloudinit_config.config.rendered
}

output "public_asg_id" {
  value = module.public_asg.asg_id
}

output "private_asg_id" {
  value = module.private_asg.asg_id
}

output "security_group_id" {
  value = aws_security_group.allow_all.id
}
