variable "aws_region" {
  type = string
}

variable "app_name" {
  type = string
}

variable "env" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_one_cidr" {
  type = string
}

variable "public_subnet_two_cidr" {
  type = string
}

variable "private_subnet_one_cidr" {
  type = string
}

variable "private_subnet_two_cidr" {
  type = string
}

variable "eks_cluster_name" {
  type = string
}

variable "eks_cluster_iam_role_name" {
  type = string
}

variable "fargate_profile_name" {
  type = string
}

variable "fargate_pod_execution_role_name" {
  type = string
}
