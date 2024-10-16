output "alb_dns" {
  value = "http://${aws_alb.application_load_balancer.dns_name}"
}