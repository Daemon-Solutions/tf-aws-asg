resource "aws_autoscaling_group" "asg" {
  count = var.enabled ? 1 : 0

  name                = var.name != null ? var.name : var.full_name
  vpc_zone_identifier = var.subnets

  launch_template {
    id      = aws_launch_template.lt[0].id
    version = "$Latest"
  }

  load_balancers    = var.load_balancers
  target_group_arns = var.target_group_arns

  min_size             = var.min
  max_size             = var.max
  default_cooldown     = var.cooldown
  termination_policies = var.termination_policies

  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type

  enabled_metrics = var.enabled_metrics

  suspended_processes = var.suspended_processes

  tag {
    key                 = "Name"
    value               = var.name != null ? var.name : var.full_name
    propagate_at_launch = true
  }
  tag {
    key                 = "Environment"
    value               = var.envname
    propagate_at_launch = true
  }
  tag {
    key                 = "Service"
    value               = var.service
    propagate_at_launch = true
  }
  tag {
    key                 = "Patch Group"
    value               = var.patch_group
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.extra_tags
    content {
      key                 = tag.value.key
      propagate_at_launch = tag.value.propagate_at_launch
      value               = tag.value.value
    }
  }
}
