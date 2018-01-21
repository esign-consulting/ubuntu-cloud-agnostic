provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "ubuntu" {
  ami = "ami-1157157d"
  instance_type = "t2.micro"
}
