variable "name" {}
variable "envname" {}
variable "service" {}

variable "ami_id" {}

variable "instance_type" {
  default = "t2.micro"
}

variable "iam_instance_profile" {
  default = ""
}

variable "security_groups" {
  type = "list"
}

variable "associate_public_ip_address" {
  default = false
}

variable "detailed_monitoring" {
  default = true
}

variable "user_data" {
  default = ""
}

variable "subnets" {
  type = "list"
}

variable "min" {
  default = 1
}

variable "max" {
  default = 1
}

variable "autoscaling" {
  default = false
}

variable "cpu_scale_up" {
  default = "60"
}

variable "scale_minutes_up" {
  default = "5"
}

variable "cpu_scale_down" {
  default = "20"
}

variable "scale_minutes_down" {
  default = "20"
}

variable "scale_factor_up" {
  default = "1"
}

variable "scale_factor_down" {
  default = "-1"
}

variable "scale_statistic" {
  default = "Maximum"
}

variable "cooldown" {
  default = 300
}

variable "key_name" {
  default = "bashton"
}

variable "termination_policies" {
  type = "list"

  default = [
    "OldestLaunchConfiguration",
    "ClosestToNextInstanceHour",
  ]
}

variable "health_check_type" {
  default = "EC2"
}

variable "health_check_grace_period" {
  default = 300
}

variable "load_balancers" {
  type    = "list"
  default = []
}

variable "target_group_arns" {
  type    = "list"
  default = []
}
