resource "aws_autoscaling_policy" "scale_policy_up" {
  count                  = "${var.autoscaling ? 1 : 0}"
  name                   = "${var.name}-scale-up"
  scaling_adjustment     = "${var.scale_factor_up}"
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${aws_autoscaling_group.asg.name}"
}

resource "aws_cloudwatch_metric_alarm" "scale_alarm_up" {
  count               = "${var.autoscaling ? 1 : 0}"
  alarm_name          = "${var.name}-scale-up"
  period              = "60"
  evaluation_periods  = "${var.scale_minutes_up}"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  statistic           = "${var.scale_statistic}"
  threshold           = "${var.cpu_scale_up}"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.asg.name}"
  }

  alarm_description = "Alarm to scale up ${var.name}"
  alarm_actions     = ["${aws_autoscaling_policy.scale_policy_up.arn}"]
}

resource "aws_autoscaling_policy" "scale_policy_down" {
  count                  = "${var.autoscaling ? 1 : 0}"
  name                   = "${var.name}-scale-down"
  scaling_adjustment     = "${var.scale_factor_down}"
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${aws_autoscaling_group.asg.name}"
}

resource "aws_cloudwatch_metric_alarm" "scale_alarm_down" {
  count               = "${var.autoscaling ? 1 : 0}"
  alarm_name          = "${var.name}-scale-down"
  period              = "60"
  evaluation_periods  = "${var.scale_minutes_down}"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  comparison_operator = "LessThanThreshold"
  statistic           = "${var.scale_statistic}"
  threshold           = "${var.cpu_scale_down}"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.asg.name}"
  }

  alarm_description = "Alarm to scale down ${var.name}"
  alarm_actions     = ["${aws_autoscaling_policy.scale_policy_down.arn}"]
}
