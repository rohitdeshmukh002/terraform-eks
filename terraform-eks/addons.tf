resource "aws_eks_addon" "coredns" {
  cluster_name  = var.cluster_name
  addon_name    = "coredns"
  addon_version = "v1.14.7-eksbuild.11"
  depends_on    = [aws_eks_cluster.rohit_eks]
}

resource "aws_eks_addon" "node_monitoring" {
  cluster_name  = var.cluster_name
  addon_name    = "eks-node-monitoring-agent"
  addon_version = "v1.7.3-eksbuild.1"
  depends_on    = [aws_eks_cluster.rohit_eks]
}

resource "aws_eks_addon" "pod_identity" {
  cluster_name  = var.cluster_name
  addon_name    = "eks-pod-identity-agent"
  addon_version = "v1.3.10-eksbuild.3"
  depends_on    = [aws_eks_cluster.rohit_eks]
}

resource "aws_eks_addon" "external_dns" {
  cluster_name  = var.cluster_name
  addon_name    = "external-dns"
  addon_version = "v0.23.0-eksbuild.2"
  depends_on    = [aws_eks_cluster.rohit_eks]
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name  = var.cluster_name
  addon_name    = "kube-proxy"
  addon_version = "v1.36.0-eksbuild.48"
  depends_on    = [aws_eks_cluster.rohit_eks]
}

resource "aws_eks_addon" "metrics_server" {
  cluster_name  = var.cluster_name
  addon_name    = "metrics-server"
  addon_version = "v0.9.0-eksbuild.13"
  depends_on    = [aws_eks_cluster.rohit_eks]
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name  = var.cluster_name
  addon_name    = "vpc-cni"
  addon_version = "v1.22.4-eksbuild.3"
  depends_on    = [aws_eks_cluster.rohit_eks]
}
