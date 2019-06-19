resource "aws_autoscaling_group" "asg" {
  count = var.enabled ? 1 : 0

  name                = var.name
  vpc_zone_identifier = var.subnets

  launch_configuration = join("", aws_launch_configuration.lc.*.id)
  load_balancers       = var.load_balancers
  target_group_arns    = var.target_group_arns

  min_size             = var.min
  max_size             = var.max
  default_cooldown     = var.cooldown
  termination_policies = var.termination_policies

  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type

  enabled_metrics = var.enabled_metrics

  tags = flatten([
    {
      key                 = "Name"
      value               = var.name
      propagate_at_launch = true
    },
    {
      key                 = "Environment"
      value               = var.envname
      propagate_at_launch = true
    },
    {
      key                 = "Service"
      value               = var.service
      propagate_at_launch = true
    },
    var.extra_tags,
    slice(
      [{
        "key"                 = "Patch Group"
        "value"               = var.patch_group
        "propagate_at_launch" = true
      }],
      var.patch_group == "" ? 1 : 0,
      1,
    ),
  ])
}
