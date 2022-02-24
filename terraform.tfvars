aws_region = "us-west-1"

# tags
app_name = "Demo"
env      = "dev"

# vpc
vpc_cidr                = "10.0.0.0/16"
public_subnet_one_cidr  = "10.0.1.0/24"
private_subnet_one_cidr = "10.0.2.0/24"
public_subnet_two_cidr  = "10.0.3.0/24"
private_subnet_two_cidr = "10.0.4.0/24"

# eks
eks_cluster_name          = "Demo"
eks_cluster_iam_role_name = "DemoEKSClusterRole"

# eks fargate
fargate_profile_name            = "default"
fargate_pod_execution_role_name = "DemoFargateExecutionRole"
