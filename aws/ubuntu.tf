provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "ubuntu" {
  ami = "ami-0f501663"
  instance_type = "t2.micro"
}
