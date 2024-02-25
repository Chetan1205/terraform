provider "aws" {
  region = "ap-southeast-2"
}

#create and apply security group in exiting instance
resource "aws_security_group" "my_sg"{
  name = "my_sg"
  description = "aalow-ssh and hhtp"
  vpc_id = var.vpc_id
  ingress{
    protocol = "TCP"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
        protocol = "TCP"
        from_port = "80"
        to_port = "80"
        cidr_blocks = ["0.0.0.0/0"]
   }
   egress {
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
   }

}

#instance created
resource "aws_instance" "new_instance"{
  ami = var.iamge_id
  instance_type = var.machine_type
  key_name = "chetan-key"
  vpc_security_group_ids = ["sg-09968fc68cf8fef58",aws_security_group.my_sg.id]
  tags = {
    Name = "new_instance"
    env = "dev"
  }
}

#instance created
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

#variable decleration
variable "iamge_id"{
  default = "ami-04f5097681773b989"
}

variable "machine_type"{
  default = "t2.micro"
}

variable "vpc_id"{
  default = "vpc-020df2b62211058e0"
}