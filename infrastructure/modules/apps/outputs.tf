output "alb_dns_name" {
  description = "Public DNS name of the load balancer"
  value       = aws_lb.nginx.dns_name
}

output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.nginx.name
}
