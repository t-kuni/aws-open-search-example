output "endpoint" {
  value = "https://${aws_elasticsearch_domain.example.endpoint}"
}

output "kibana_endpoint" {
  value = "https://${aws_elasticsearch_domain.example.kibana_endpoint}"
}