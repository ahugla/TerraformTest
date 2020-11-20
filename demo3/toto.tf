
provider "aws" {
  version = "2.69.0"
  region = "eu-west-1"
}


variable "myTag" {
  description = "My Input Tag"
  default = "alextag"
}


resource "aws_instance" "web" {
  ami = "ami-08a2aed6e0a6f9c7d"
  instance_type = "t2.micro"
  tags = {
  "type" = var.myTag
  }
}




