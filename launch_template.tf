// Launch Template
resource "aws_launch_template" "lt" {
  count = var.enabled ? 1 : 0

  name_prefix = var.name
  name        = var.full_name

  dynamic "block_device_mappings" {
    for_each = var.ebs_block_device
    content {
      device_name  = lookup(block_device_mappings.value, "device_name", null)
      no_device    = lookup(block_device_mappings.value, "no_device", null)
      virtual_name = lookup(block_device_mappings.value, "virtual_name", null)

      dynamic "ebs" {
        for_each = lookup(block_device_mappings.value, "ebs", null) == null ? [] : ["ebs"]
        content {
          delete_on_termination = lookup(block_device_mappings.value.ebs, "delete_on_termination", null)
          encrypted             = lookup(block_device_mappings.value.ebs, "encrypted", null)
          iops                  = lookup(block_device_mappings.value.ebs, "iops", null)
          kms_key_id            = lookup(block_device_mappings.value.ebs, "kms_key_id", null)
          snapshot_id           = lookup(block_device_mappings.value.ebs, "snapshot_id", null)
          volume_size           = lookup(block_device_mappings.value.ebs, "volume_size", null)
          volume_type           = lookup(block_device_mappings.value.ebs, "volume_type", null)
        }
      }
    }
  }

  update_default_version = var.update_default_version
  network_interfaces {
    device_index                = 0
    associate_public_ip_address = var.associate_public_ip_address
    delete_on_termination       = true
    security_groups             = var.security_groups
  }

  credit_specification {
    cpu_credits = "standard"
  }

  iam_instance_profile {
    name = var.iam_instance_profile
  }

  image_id = var.ami_id

  instance_type = var.instance_type

  key_name = var.key_name

  monitoring {
    enabled = var.detailed_monitoring
  }

  user_data = base64encode(var.user_data)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [user_data]
  }

}


