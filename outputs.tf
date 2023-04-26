output "vercel-app-url" {
  value = vercel_deployment.frontend.url
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.cc-terraform-db.endpoint
}

output "api_url" {
  description = "The API URL"
  value       = digitalocean_app.golang-gin-api.live_url
}
