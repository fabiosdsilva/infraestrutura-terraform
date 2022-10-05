resource "aws_route53_zone" "main" {
  name = var.name
}

resource "aws_route53_record" "dev-ns" {
  count = length(var.records)

  zone_id = aws_route53_zone.main.zone_id

  name    = var.records[count.index].name
  type    = var.records[count.index].type
  ttl     = var.records[count.index].ttl
  records = ["${var.records[count.index].records}"]
}