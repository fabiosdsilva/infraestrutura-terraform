## Key pairs
module "key_pairs" {
  source = "./terraform-modules-aws/key_pairs"

  key_name = [
    "web-server"
  ]
}

## Ec2
module "ec2" {
  source = "./terraform-modules-aws/ec2"

  ec2-web-servers = [
    {
      name          = "web-server-nginx"
      instance_type = "t2.micro"
      key_name      = "web-server"
      volume_size   = 8
      volume_type   = "gp3"
    }
  ]

  depends_on = [
    module.key_pairs
  ]
}

## Route 53
module "route_53" {
  source = "./terraform-modules-aws/route_53"

  ## Nome da zona de hospedagem
  name = "infraascode.online"

  ## Subdominios
  records = [
    {
      name    = "web-server.infraascode.online"
      type    = "A"
      ttl     = 300
      records = ["${module.ec2.instance_address[0]}"]
    }
  ]

  depends_on = [
    module.ec2
  ]
}

## Outputs
output "public_ip" {
  value = module.ec2.instance_address
}

output "public_dns" {
  value = module.ec2.instance_address_dns
}

output "record_name" {
  value = module.route_53.record_name
}