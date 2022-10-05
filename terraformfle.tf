## Ec2
module "ec2" {
  source = "./terraform-modules-aws/ec2"

  ec2-web-servers = [
    {
      name          = "web-server-nginx"
      instance_type = "t2.micro"
      key_name      = ""
      volume_size   = 8
      volume_type   = "gp3"
    }
  ]
}