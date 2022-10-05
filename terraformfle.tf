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

## Outputs
output "public_ip" {
  value = module.ec2.instance_address
}