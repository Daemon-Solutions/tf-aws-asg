output "launch_config_id" {
    value = "${aws_launch_configuration.lc.id}"
}
output "asg_id" {
    value = "${aws_autoscaling_group.asg.id}"
}
output "asg_name" {
    value = "${aws_autoscaling_group.asg.name}"
}
