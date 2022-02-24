#--------------------------------------------------------------------------------------
# create iam role for fargate
#--------------------------------------------------------------------------------------
resource "aws_iam_role" "fargate_pod_execution_role" {
  name                  = var.fargate_pod_execution_role_name
  force_detach_policies = true

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "eks.amazonaws.com",
          "eks-fargate-pods.amazonaws.com"
          ]
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

resource "aws_iam_role_policy_attachment" "AmazonEKSFargatePodExecutionRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.fargate_pod_execution_role.name
}



#--------------------------------------------------------------------------------------
# create fargate profile
#--------------------------------------------------------------------------------------
resource "aws_eks_fargate_profile" "main" {
  cluster_name           = var.eks_cluster_name
  fargate_profile_name   = var.fargate_profile_name
  pod_execution_role_arn = aws_iam_role.fargate_pod_execution_role.arn
  subnet_ids             = var.private_subnet_ids

  selector {
    namespace = "default"
  }

  selector {
    namespace = "kube-system"
  }

  tags = {
    name = var.app_name
    env  = var.env
  }
}
