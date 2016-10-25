// Global Configuration
variable "name" { }
variable "envname" { }
variable "service" { }

// Launch Configuration Variables
variable "ami_id" { }
variable "instance_type" { default = "t2.micro" }
variable "iam_instance_profile" { }
variable "key_name" { }
variable "security_groups" { }
variable "user_data" {
  description = "Content of userdata file"
}
variable "associate_public_ip_address" { default = false }
variable "detailed_monitoring" { default = false }

// Auto-Scaling Group
variable "subnets" { }
variable "availability_zones" { }
variable "asg_min" { default = 0 }
variable "asg_max" { default = 1 }
variable "health_check_type" { default = "EC2" }
variable "health_check_grace_period" { default = 300 }
