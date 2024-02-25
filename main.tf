provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "new_instance"{
  ami = var.iamge_id
  instance_type = var.machine_type
  key_name = "chetan-key"
  vpc_security_group_ids = ["sg-09968fc68cf8fef58"]
  tags = {
    Name = "new_instance"
    env = "dev"
  }
}

resource "aws_instance" "new_instance2"{
  ami = var.iamge_id
  instance_type = var.machine_type
  key_name = "chetan-key"
  vpc_security_group_ids = ["sg-09968fc68cf8fef58"]
  tags = {
    Name = "new_instance2"
    env = "dev"
  }
}

variable "iamge_id"{
  default = "ami-04f5097681773b989"
}

variable "machine_type"{
  default = "t2.micro"
}