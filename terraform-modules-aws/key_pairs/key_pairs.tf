resource "tls_private_key" "tsl_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  for_each = var.name

  key_name   = each.value
  public_key = tls_private_key.sl_key_pair.public_key_openssh
}

resource "aws_secretsmanager_secret" "key-web-server" {
  name = "key-web-server"
}

resource "aws_secretsmanager_secret_version" "example" {
  for_each = aws_key_pairkey_pair.private_key

  secret_id     = aws_secretsmanager_secret.key-web-server.id
  secret_string = each.value
}
