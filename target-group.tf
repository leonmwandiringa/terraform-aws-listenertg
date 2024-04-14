resource "aws_lb_target_group" "default" {
  name                          = var.target_group_name
  port                          = var.target_group_port
  protocol                      = var.target_group_protocol
  protocol_version              = var.target_group_target_type == "HTTP" || var.target_group_target_type == "HTTPS" ? var.target_group_protocol_version : null
  vpc_id                        = var.vpc_id
  target_type                   = var.target_group_target_type
  load_balancing_algorithm_type = var.load_balancing_algorithm_type
  deregistration_delay          = var.deregistration_delay
  slow_start                    = var.slow_start

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    var.tags,
    {
        Name = "${var.tags.Name}-target-group"
    }
  )
}