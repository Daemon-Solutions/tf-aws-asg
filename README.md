# tf-aws-asg

AWS Autoscaling group Terraform Module.

Built loosely as a replacement for `autoscaling.json` used in CloudFormation in antiquity.

Gives you:

 - An autoscaling group
 - A launch config
 - Optionally a CPU based policy to scale up/down

It is suggested you use `tf-aws-sg` and `tf-aws-iam-instance-profile` in conjunction with this module.
You can create one or more ELBs with `tf-aws-elb`, and pass a list of load balancers in.

## Usage

```
data "template_file" "cc" {
  template = "${file("templates/cloud-config.cfg.tpl")}"
}

data "template_file" "script" {
  template = "${file("templates/boot.sh.tpl")}"
}

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = "${data.template_file.cc.rendered}"
  }

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.script.rendered}"
  }
}

module "asg" {
  source    = "git::ssh://git@gogs.bashton.net/Bashton-Terraform-Modules/tf-aws-asg.git"
  name      = "my-asg"
  envname   = "test"
  service   = "varnish"
  ami_id    = "ami-a85165db"
  user_data = "${data.template_cloudinit_config.config.rendered}"
}
```

## Variables

Variables marked with an * are mandatory, the others have sane defaults and can be omitted.

* `name`\* - Name given to autoscaling group and the instances it creates
* `envname`\* - Environment name (eg,test, stage or prod)
* `service`\* - Service name
* `ami_id`\* - AMI to use
* `subnets`\* - List of subnet IDs to use
* `security_groups`\* - List of security groups to use
* `user_data` - User data
* `instance_type` - Instance type to use (default: `t2.micro`)
* `iam_instance_profile` - IAM instance profile to attach
* `key_name` - SSH key to use
* `associate_public_ip_address` - whether to give machines public IPs
* `detailed_monitoring` - If false only add machine stats to CloudWatch every 5 minutes (default: `true`)
* `min` - Minimum number of instances (default: `1`)
* `max` - Maximum number of instances (default: `1`)
* `autoscaling` - Boolean, whether to enable CPU based auto scaling
* `cpu_scale_up` - CPU % to scale up at if `autoscaling` true (default: `60`)
* `cpu_scale_down` - CPU % to scale down at, if `autoscaling` true (default: `20`)
* `scale_miutes_up` - Scale up when CPU above threshold for this number of minutes (default: `5`)
* `scale_miutes_down` - Scale down when CPU above threshold for this number of minutes (default: `20`)
* `scale_factor_up` - Number of instances to add when scaling up (default: `1`)
* `scale_factor_down` - Number of instances to add when scaling down, should be a negative number (default: `-1`)
* `scale_statistic` - Statistic to use for scaling up/down - SampleCount, Average, Sum, Minimum or Maximum (default: `Maximum`)
* `cooldown` - The amount of time, in seconds, after a scaling activity completes before another scaling activity can start (300)
* `termination_policies` - List of termination policies
* `health_check_type` - Should be `EC2` or `ELB` (default: `EC2`)
* `health_check_grace_period` - Delay before checking instance health
* `load_balancers` - List of ELBs
* `target_group_arns` - A list of aws_alb_target_group ARNs, for use with Application Load Balancing
* `enabled_metrics` - A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances


## Outputs

* `asg_name` - Autoscaling group name
* `asg_id` - Autoscaling group id
* `asg_arn` - Autoscaling group ARN
* `launch_config_id` - Launch configuration id
* `scale_up_alarm` - CloudWatch alarm for scaling up
* `scale_down_alarm` - CloudWatch alarm for scaling down


# Testing

Run `make test` in the tests/ directory

# TODO

 - Proper automated tests
