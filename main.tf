provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "new_instance"{
  ami = "ami-04f5097681773b989"
  instance_type = "t2.micro"
  key_name = "chetan-key"
  vpc_security_group_ids = ["sg-09968fc68cf8fef58"]
  tags = {
    Name = "new_instance"
    env = "dev"
  }
}