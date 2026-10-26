resource "aws_eks_addon" "ebs_csi" {
  cluster_name = aws_eks_cluster.my_cluster.name
  addon_name   = "aws-ebs-csi-driver"

  addon_version = "v1.67.2-eksbuild.1"

  depends_on = [
    aws_iam_role_policy_attachment.ebs_csi,
    aws_eks_cluster.my_cluster,
    aws_eks_addon.pod_identity
  ]
}


resource "aws_eks_addon" "coredns" {
  cluster_name = "argo-cluster"
  addon_name   = "coredns"
  addon_version = "v1.14.7-eksbuild.19"
  depends_on = [aws_eks_cluster.my_cluster]
}

resource "aws_eks_addon" "node_monitoring" {
  cluster_name = "argo-cluster"
  addon_name   = "eks-node-monitoring-agent"
  addon_version = "v1.7.5-eksbuild.1"
  depends_on = [aws_eks_cluster.my_cluster]
}

resource "aws_eks_addon" "pod_identity" {
  cluster_name = "argo-cluster"
  addon_name   = "eks-pod-identity-agent"
  addon_version = "v1.4.1-eksbuild.3"
  depends_on = [aws_eks_cluster.my_cluster]
}

resource "aws_eks_addon" "external_dns" {
  cluster_name = "argo-cluster"
  addon_name   = "external-dns"
  addon_version = "v0.23.0-eksbuild.3"
  depends_on = [aws_eks_cluster.my_cluster]
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name = "argo-cluster"
  addon_name   = "kube-proxy"
  addon_version = "v1.36.0-eksbuild.55"
  depends_on = [aws_eks_cluster.my_cluster]
}

resource "aws_eks_addon" "metrics_server" {
  cluster_name = "argo-cluster"
  addon_name   = "metrics-server"
  addon_version = "v0.9.0-eksbuild.14"
  depends_on = [aws_eks_cluster.my_cluster]
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name = "argo-cluster"
  addon_name   = "vpc-cni"
  addon_version = "v1.22.4-eksbuild.8"
  depends_on = [aws_eks_cluster.my_cluster]
}