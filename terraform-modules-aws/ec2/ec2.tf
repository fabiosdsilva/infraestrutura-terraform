data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"] #Ubuntu
}

resource "aws_instance" "web-servers" {
  for_each = var.ec2-web-servers

  ami           = data.aws_ami.ubuntu.id
  instance_type = each.value.instance_type
  key_name      = each.value.key_name

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = each.value.volume_size
    volume_type = each.value.volume_type
  }

  tags = {
    Name = "${trimspace(each.value.name)}"
  }

}