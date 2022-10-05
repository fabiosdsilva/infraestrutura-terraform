output "instance_address" {
    value = {
        for i, k in aws_instance.web-servers: i => k.ip_public
    }
}