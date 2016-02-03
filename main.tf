// Launch Configuration
resource "aws_launch_configuration" "lc" {
  lifecycle {
    create_before_destroy = true
  }

  security_groups = ["${split(",", var.security_groups)}"]

  image_id = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  iam_instance_profile = "${var.iam_instance_profile}"
  key_name = "${var.key_name}"
  user_data = "${var.user_data}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  enable_monitoring = "${var.detailed_monitoring}"
}

// Auto-Scaling Group Configuration
resource "aws_autoscaling_group" "asg" {
  name = "${var.name}"
  availability_zones = ["${split(",", var.availability_zones)}"]
  vpc_zone_identifier = ["${split(",", var.subnets)}"]

  // Use the Name from the launch config created above
  launch_configuration = "${aws_launch_configuration.lc.name}"

  min_size = "${var.asg_min}"
  max_size = "${var.asg_max}"

  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type = "${var.health_check_type}"

  tag { key = "Name" value = "${var.name}" propagate_at_launch = true }
  tag { key = "Environment" value = "${var.envname}" propagate_at_launch = true }
  tag { key = "Service" value = "${var.service}" propagate_at_launch = true }

}
