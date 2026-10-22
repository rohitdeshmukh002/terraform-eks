data "aws_iam_instance_profile" "node" {
  name = var.node_instance_profile_name
}

resource "aws_eks_node_group" "eks-grp" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_grp

  node_role_arn = data.aws_iam_instance_profile.node.role_arn

  subnet_ids = [
    "subnet-0a72bd2c4d45ccb3d",
    "subnet-04f2022a8e6c79cd9",
    "subnet-04d8c5f3617bae491"
  ]

  version        = "1.36"
  ami_type       = "AL2023_x86_64_STANDARD"
  capacity_type  = "SPOT"
  instance_types = [var.instance_type]
  disk_size      = 20

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 2
  }

  tags = {
    "k8s.io/cluster-autoscaler/enabled"          = "true"
    "k8s.io/cluster-autoscaler/Pathnex-Sep-2026" = "owned"
  }

  lifecycle {
    ignore_changes = [
      scaling_config[0].desired_size
    ]
  }



  update_config {
    max_unavailable = 1
    update_strategy = "DEFAULT"
  }

  remote_access {
    ec2_ssh_key = "cluster.pub"

    source_security_group_ids = [var.security_grp]
  }
}
