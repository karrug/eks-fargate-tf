#--------------------------------------------------------------------------------------
# create vpc
#--------------------------------------------------------------------------------------
module "vpc" {
  source                  = "./modules/vpc"
  app_name                = var.app_name
  env                     = var.env
  vpc_cidr                = var.vpc_cidr
  public_subnet_one_cidr  = var.public_subnet_one_cidr
  public_subnet_two_cidr  = var.public_subnet_two_cidr
  private_subnet_one_cidr = var.private_subnet_one_cidr
  private_subnet_two_cidr = var.private_subnet_two_cidr
}

#--------------------------------------------------------------------------------------
# create eks cluster
#--------------------------------------------------------------------------------------
module "eks" {
  source                    = "./modules/eks"
  eks_cluster_name          = var.eks_cluster_name
  eks_cluster_iam_role_name = var.eks_cluster_iam_role_name
  eks_cluster_subnet_ids    = module.vpc.subnet_ids
  app_name                  = var.app_name
  env                       = var.env
}

#--------------------------------------------------------------------------------------
# create fargate profile for eks cluster
#--------------------------------------------------------------------------------------
module "eks_fargate" {
  source                          = "./modules/eks_fargate"
  eks_cluster_name                = var.eks_cluster_name
  fargate_profile_name            = var.fargate_profile_name
  fargate_pod_execution_role_name = var.fargate_pod_execution_role_name
  private_subnet_ids              = module.vpc.private_subnet_ids
  app_name                        = var.app_name
  env                             = var.env

  depends_on = [
    module.eks
  ]
}
