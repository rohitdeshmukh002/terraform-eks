resource "aws_eks_cluster" "rohit_eks" {
  name     = var.cluster_name
  version  = "1.36"
  role_arn = "arn:aws:iam::034971967372:role/AmazonEKSClusterRole"

  upgrade_policy {
    support_type = var.upgrade_policy
  }

  vpc_config {
    subnet_ids = [for subnet in var.subnet_ids : subnet]

    security_group_ids = [var.security_group_ids]

    public_access_cidrs = [var.public_access_cidrs]

    endpoint_public_access  = true
    endpoint_private_access = true
  }

  zonal_shift_config {
    enabled = false
  }
}