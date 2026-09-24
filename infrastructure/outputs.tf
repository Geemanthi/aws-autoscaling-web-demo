output "alb_dns_name" {
	description = "DNS name of the Application Load Balancer"
	value       = module.apps.alb_dns_name
}
