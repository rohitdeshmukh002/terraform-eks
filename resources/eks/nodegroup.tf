resource "aws_eks_node_group" "pathnex-NG" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = "eks-ng"

  node_role_arn = "arn:aws:iam::034971967372:role/AmazonEKSNodeRole"

  subnet_ids = [
    "subnet-0a72bd2c4d45ccb3d",
    "subnet-04f2022a8e6c79cd9",
    "subnet-04d8c5f3617bae491"
  ]


  version        = "1.36"
  ami_type       = "AL2023_x86_64_STANDARD"
  capacity_type  = "SPOT"
  instance_types = ["t3.small"]
  disk_size      = 20

  scaling_config {
    desired_size = 2
    min_size     = 2
    max_size     = 3
  }

tags = {
  "k8s.io/cluster-autoscaler/enabled"       = "true"
  "k8s.io/cluster-autoscaler/argo-cluster"  = "owned"
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
    ec2_ssh_key = "server_key"

    source_security_group_ids = [
      "sg-060c79da774aadc47"
    ]
  }
}