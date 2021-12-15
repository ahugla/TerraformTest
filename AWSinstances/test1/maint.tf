provider "aws" {
  region = "eu-west-3"
  access_key = "key"
  secret_key = "secret"
}



resource "aws_instance" "web" {
  instance_type = "t2.nano"

  ami = var.myAMI

  tags = {
  "type" = var.myTag
  }

}
