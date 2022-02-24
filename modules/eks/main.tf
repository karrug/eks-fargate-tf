#--------------------------------------------------------------------------------------
# create iam role for eks
#--------------------------------------------------------------------------------------
resource "aws_iam_role" "eks_cluster" {
  name = var.eks_cluster_iam_role_name

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

  tags = {
    name = var.app_name
    env  = var.env
  }
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster.name
}


#--------------------------------------------------------------------------------------
# create eks cluster
#--------------------------------------------------------------------------------------
resource "aws_eks_cluster" "eks_cluster" {
  name                      = var.eks_cluster_name
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  role_arn                  = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = var.eks_cluster_subnet_ids
  }

  tags = {
    name = var.app_name
    env  = var.env
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy
  ]
}
