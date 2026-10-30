resource "aws_eks_node_group" "rohit_ng" {
  cluster_name    = aws_eks_cluster.rohit_eks.name
  node_group_name = var.node_group_name

  node_role_arn = "arn:aws:iam::034971967372:role/AmazonEKSNodeRole"

  subnet_ids = [for subnet in var.subnet_ids : subnet]

  version        = var.cluster_version
  ami_type       = var.ami_type
  capacity_type  = "SPOT"
  instance_types = [var.instance_type]
  disk_size      = 20

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  tags = {
    "k8s.io/cluster-autoscaler/enabled"   = "true"
    "k8s.io/cluster-autoscaler/rohit-eks" = "owned"
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
    ec2_ssh_key               = aws_key_pair.nodegroup_key.key_name
    source_security_group_ids = [var.security_group_ids]
  }
}

resource "aws_key_pair" "nodegroup_key" {
  key_name   = var.key_name
  public_key = file("eks-key.pub")
}