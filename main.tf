provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket  = "infraestrutura-terraform"
    key     = "terraform.state"
    region  = "us-east-1"
    encrypt = true
  }
}