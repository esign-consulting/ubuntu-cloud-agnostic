provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "ubuntu" {
  ami = "ami-1157157d"
  instance_type = "t2.micro"
  associate_public_ip_address = true

  provisioner "local-exec" {
    command = "echo '[ubuntu]\n${aws_instance.ubuntu.public_ip}' > hosts"
  }
}
