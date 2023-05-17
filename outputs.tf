output "target_group_arn" {
  description = "The target group ARN"
  value       = aws_lb_target_group.default.arn
}

output "target_group_arn_suffix" {
  description = "The default target group ARN suffix"
  value       = aws_lb_target_group.default.arn_suffix
}

output "http_listener_arn" {
  description = "The ARN of the HTTP forwarding listener"
  value       = join("", aws_lb_listener.http_forward.*.arn)
}

output "http_redirect_listener_arn" {
  description = "The ARN of the HTTP to HTTPS redirect listener"
  value       = join("", aws_lb_listener.http_redirect.*.arn)
}

output "https_listener_arn" {
  description = "The ARN of the HTTPS listener"
  value       = join("", aws_lb_listener.https.*.arn)
}

output "listener_arns" {
  description = "A list of all the listener ARNs"
  value = [join("", aws_lb_listener.http_forward.*.arn), join("", aws_lb_listener.http_redirect.*.arn), join("", aws_lb_listener.https.*.arn)]
}
