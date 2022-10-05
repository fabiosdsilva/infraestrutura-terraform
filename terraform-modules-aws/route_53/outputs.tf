output "record_name" {
  value = {
    for i, record in aws_route53_record.server: i => record.name 
  }
}