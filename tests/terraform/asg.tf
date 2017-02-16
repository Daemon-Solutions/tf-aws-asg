resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${module.vpc.vpc_id}"

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

module "public-asg" {
  source                      = "../../"
  name                        = "awspec-testing-public"
  envname                     = "foo"
  service                     = "bar"
  subnets                     = ["${module.vpc.public_subnets}"]
  security_groups             = ["${aws_security_group.allow_all.id}"]
  ami_id                      = "ami-a85165db"
  associate_public_ip_address = true
  user_data                   = "${data.template_cloudinit_config.config.rendered}"
}

module "private-asg" {
  source                      = "../../"
  name                        = "awspec-testing-private"
  envname                     = "foo"
  service                     = "bar"
  subnets                     = ["${module.vpc.private_subnets}"]
  security_groups             = ["${aws_security_group.allow_all.id}"]
  ami_id                      = "ami-a85165db"
  associate_public_ip_address = false
  min                         = 1
  max                         = 3
  autoscaling                 = true
  cpu_scale_up                = "50"
  cpu_scale_down              = "20"
  user_data                   = "${data.template_cloudinit_config.config.rendered}"
}
