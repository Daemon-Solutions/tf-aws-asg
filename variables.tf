/* Environment */
variable "enabled" {
  description = "Enable or disable the ASG."
  type        = string
  default     = "1"
}

variable "name" {
  description = "The desired name prefix for your ASG resources. Will also be added as the value for the 'Name' tag"
  type        = string
  default     = null
}

variable "full_name" {
  description = "Full name of the resource (as opposed to prefix), in order to retain laguna compatibility"
  type        = string
  default     = null
}

variable "envname" {
  description = "This will become the value for the 'Environment' tag on resources created by this module"
  type        = string
}

variable "service" {
  description = "This will become the value for the 'Service' tag on resources created by this module"
  type        = string
}

/* Autoscale Group Variables - Instance */
variable "ami_id" {
  description = "The AMI used to create ASG instances"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the ASG to create"
  type        = string
  default     = "t2.micro"
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance"
  type        = list(any)
  default     = []
}

variable "ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  type        = list(any)
  default     = []
}

variable "ephemeral_block_device" {
  description = "Customize Ephemeral (also known as 'Instance Store') volumes on the instance"
  type        = list(any)
  default     = []
}

variable "iam_instance_profile" {
  description = "The IAM instance profile to associate with launched instances"
  type        = string
  default     = ""
}

variable "security_groups" {
  description = "A list of associated security group IDS"
  type        = list(string)
  default     = []
}

variable "associate_public_ip_address" {
  description = "Associate a public ip address with an ASG launched instance"
  type        = string
  default     = false
}

variable "key_name" {
  description = "The key name that should be used for the ASG launched instances"
  type        = string
  default     = "bashton"
}

variable "detailed_monitoring" {
  description = "Enables/disables detailed monitoring"
  type        = string
  default     = true
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  type        = string
  default     = ""
}

variable "subnets" {
  description = "A list of subnet IDs to launch resources in"
  type        = list(string)
}

/* Autoscale Group Variables - Scaling */
variable "min" {
  description = "The minimum size of the Autoscale Group"
  type        = string
  default     = 1
}

variable "max" {
  description = "The maximum size of the Autoscale Group"
  type        = string
  default     = 1
}

variable "autoscaling" {
  description = "Bool indicating whether to create Autoscale Policies"
  type        = string
  default     = false
}

variable "scaling_policy_type" {
  description = "Autoscaling strategy"
  type        = string
  default     = "SimpleScaling"
}

variable "target_tracking_target_cpu" {
  description = "Bool indicating whether to create target tracking scaling policy"
  type        = string
  default     = "60"
}

variable "warmup_seconds" {
  description = "The estimated time, in seconds, until a newly launched instance will contribute CloudWatch metrics"
  type        = string
  default     = "60"
}

variable "cpu_scale_up" {
  description = "The value against which the CPU usage is compared to decide scale up action"
  type        = string
  default     = "60"
}

variable "scale_minutes_up" {
  description = "How many minutes should pass before a scale up event should occur if the cpu_scale_up threshold is exceeded"
  type        = string
  default     = "5"
}

variable "cpu_scale_down" {
  description = "The value against which the CPU usage is compared to decide scale down action"
  type        = string
  default     = "20"
}

variable "scale_minutes_down" {
  description = "How many minutes should pass before a scale down event should occur if the cpu_scale_up threshold is no longer exceeded"
  type        = string
  default     = "20"
}

variable "scale_factor_up" {
  description = "The number of instances by which to scale up by at a time"
  type        = string
  default     = "1"
}

variable "scale_factor_down" {
  description = "The number of instances by which to scale down by at a time"
  type        = string
  default     = "-1"
}

variable "scale_statistic" {
  description = "The statistic to apply to the Autoscale alarm's associated metric"
  type        = string
  default     = "Maximum"
}

variable "cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start"
  type        = string
  default     = 300
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated"
  type        = list(string)

  default = [
    "OldestLaunchConfiguration",
    "ClosestToNextInstanceHour",
  ]
}

variable "health_check_type" {
  description = "This value controls how health checking is done"
  type        = string
  default     = "EC2"
}

variable "health_check_grace_period" {
  description = "Time (seconds) after instance comes into service before checking health"
  type        = string
  default     = 300
}

variable "load_balancers" {
  description = "A list of Elastic Load Balancer names to add to the autoscaling group names"
  type        = list(string)
  default     = []
}

variable "target_group_arns" {
  description = "A list of aws_alb_target_group ARNs, for use with Application Load Balancing"
  type        = list(string)
  default     = []
}

variable "enabled_metrics" {
  description = "A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances"
  type        = list(string)

  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
}

variable "patch_group" {
  description = "Adds a 'Patch Group' tag to the ASG with this value"
  type        = string
  default     = ""
}

variable "use_default_tags" {
  description = "Bool indicating whether to apply default tags"
  type        = bool
  default     = true
}

variable "extra_tags" {
  description = "A list of extra tags for the ASG"
  type        = list(any)
  default     = []
}

variable "suspended_processes" {
  description = "List of processes to suspend for the ASG"
  type        = list(string)
  default     = []
}
