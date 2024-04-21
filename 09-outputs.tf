output "load_balancer_dns_name" {
  value = aws_lb.app.dns_name
  description = "DNS name for the application load balancer"
}
