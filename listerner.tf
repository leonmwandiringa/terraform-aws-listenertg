resource "aws_lb_listener" "tcp_udp_forward" {
  count             = var.tcp_udp_enabled != true ? 1 : 0
  load_balancer_arn = var.load_balancer_arn
  port              = var.tcp_udp_port
  protocol          = "TCP_UDP"
  tags              = merge(var.tags, {
    Name = "TCP_UDP Forward Listener"
  })

  default_action {
    target_group_arn = aws_lb_target_group.default.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "http_forward" {
  count             = var.http_enabled && var.http_redirect != true ? 1 : 0
  load_balancer_arn = var.load_balancer_arn
  port              = var.http_port
  protocol          = "HTTP"
  tags              = merge(var.tags, {
    Name = "HTTP Forward Listener"
  })

  default_action {
    target_group_arn = aws_lb_target_group.default.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "http_redirect" {
  count             = var.http_enabled && var.http_redirect == true ? 1 : 0
  load_balancer_arn = var.load_balancer_arn
  port              = var.http_port
  protocol          = "HTTP"
  tags              = merge(var.tags, {
    Name = "HTTP Redirect Listener"
  })

  default_action {
    target_group_arn = aws_lb_target_group.default.arn
    type             = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  count             = var.https_enabled ? 1 : 0
  load_balancer_arn = var.load_balancer_arn

  port            = var.https_port
  protocol        = "HTTPS"
  ssl_policy      = var.https_ssl_policy
  certificate_arn = var.certificate_arn
  tags              = merge(var.tags, {
    Name = "HTTPs Forward Listener"
  })

  default_action {
    target_group_arn = aws_lb_target_group.default.arn
    type             = "forward"
  }
}

