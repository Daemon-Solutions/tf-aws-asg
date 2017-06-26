resource "aws_autoscaling_group" "asg" {
  name                = "${var.name}"
  vpc_zone_identifier = ["${var.subnets}"]

  launch_configuration = "${aws_launch_configuration.lc.name}"
  load_balancers       = ["${var.load_balancers}"]
  target_group_arns    = ["${var.target_group_arns}"]

  min_size             = "${var.min}"
  max_size             = "${var.max}"
  default_cooldown     = "${var.cooldown}"
  termination_policies = ["${var.termination_policies}"]

  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"

  enabled_metrics = ["${var.enabled_metrics}"]

  tag {
    key = "Name"

    value = "${var.name}"

    propagate_at_launch = true
  }

  tag {
    key = "Environment"

    value = "${var.envname}"

    propagate_at_launch = true
  }

  tag {
    key = "Service"

    value = "${var.service}"

    propagate_at_launch = true
  }

  tag {
    key = "Patch Group"

    value = "${var.patch_group}"

    propagate_at_launch = true
  }
  
  tags = "${merge(var.default_tags, map('EnvironmentType', '${var.envtype}', map('EnvironmentName', '${var.envname}', map('Profile', '${var.profile}')}"
  
}
