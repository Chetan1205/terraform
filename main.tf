provider "aws" {
    region = "eu-west-3"
}

data "aws_iam_policy_document" "assume-role" {
    statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "my_role" {
    name      = "my-eks-cluster"
    assume_role_policy = data.aws_iam_policy_document.assume-role.json
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
   role       = aws_iam_role.my_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
   role       = aws_iam_role.my_role.name
}


resource "aws_eks_cluster" "eks-cluster" {
   name     = "my-cluster"
   role_arn = aws_iam_role.my_role.arn

   vpc_config {
     subnet_ids = [
         "subnet-0b334f21255855b3e",
         "subnet-083e357b54c924fc8",
         "subnet-0257ef8ab450e1e5b"
         ]
  }
  
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]
}
