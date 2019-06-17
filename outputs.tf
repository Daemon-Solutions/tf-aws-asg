output "launch_config_id" {
  value = join("", aws_launch_configuration.lc.*.id)
}

output "asg_id" {
  value = join("", aws_autoscaling_group.asg.*.id)
}

output "asg_name" {
  value = join("", aws_autoscaling_group.asg.*.name)
}

output "asg_arn" {
  value = join("", aws_autoscaling_group.asg.*.arn)
}
