variable "app_name" {
  type = string
}

variable "env" {
  type = string
}

variable "eks_cluster_name" {
  type = string
}

variable "fargate_profile_name" {
  type = string
}

variable "fargate_pod_execution_role_name" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}
