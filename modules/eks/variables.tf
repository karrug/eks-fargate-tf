variable "app_name" {
  type = string
}

variable "env" {
  type = string
}

variable "eks_cluster_name" {
  type = string
}

variable "eks_cluster_iam_role_name" {
  type = string
}

variable "eks_cluster_subnet_ids" {
  type = list(string)
}
