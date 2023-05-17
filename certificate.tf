resource "aws_lb_listener_certificate" "https_sni" {
  count           = var.https_enabled && var.certificates != [] ? length(var.certificates) : 0
  listener_arn    = join("", aws_lb_listener.https.*.arn)
  certificate_arn = var.certificates[count.index]
}
