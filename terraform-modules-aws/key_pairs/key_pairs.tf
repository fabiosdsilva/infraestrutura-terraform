resource "tls_private_key" "tsl_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  count      = length(var.key_name)

  key_name   = var.key_name[count.index]
  public_key = tls_private_key.tsl_key_pair.public_key_openssh
}

resource "aws_secretsmanager_secret" "key-web-server" {
  count = length(var.key_name)

  name  = "${var.key_name[count.index]}"
}

resource "aws_secretsmanager_secret_version" "secret_kms" {
  count         = length(var.key_name)

  secret_id     = aws_secretsmanager_secret.key-web-server[count.index].id
  secret_string = "${tls_private_key.tsl_key_pair.private_key_pem}"
}
