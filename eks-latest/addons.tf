resource "aws_eks_addon" "pod_identity" {
  cluster_name  = aws_eks_cluster.rohit_eks.name
  addon_name    = "eks-pod-identity-agent"
  addon_version = "v1.4.1-eksbuild.3"
  depends_on    = [aws_eks_cluster.rohit_eks]
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name  = aws_eks_cluster.rohit_eks.name
  addon_name    = "vpc-cni"
  addon_version = "v1.22.4-eksbuild.8"
  depends_on    = [aws_eks_cluster.rohit_eks]
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name  = aws_eks_cluster.rohit_eks.name
  addon_name    = "kube-proxy"
  addon_version = "v1.36.0-eksbuild.55"
  depends_on    = [aws_eks_cluster.rohit_eks]
}

resource "aws_eks_addon" "core_dns" {
  cluster_name  = aws_eks_cluster.rohit_eks.name
  addon_name    = "coredns"
  addon_version = "v1.14.7-eksbuild.19"
  depends_on    = [aws_eks_node_group.rohit_ng] # CoreDNS often needs worker nodes to run smoothly
}

resource "aws_eks_addon" "ebs_csi" {
  cluster_name  = aws_eks_cluster.rohit_eks.name
  addon_name    = "aws-ebs-csi-driver"
  addon_version = "v1.67.2-eksbuild.1"

  depends_on = [
    aws_iam_role_policy_attachment.ebs_csi,
    aws_eks_cluster.rohit_eks,
    aws_eks_addon.pod_identity
  ]
}

resource "aws_eks_addon" "node_monitoring" {
  cluster_name  = aws_eks_cluster.rohit_eks.name
  addon_name    = "eks-node-monitoring-agent"
  addon_version = "v1.7.5-eksbuild.1"
  depends_on    = [aws_eks_cluster.rohit_eks]
}

resource "aws_eks_addon" "metrics_server" {
  cluster_name  = aws_eks_cluster.rohit_eks.name
  addon_name    = "metrics-server"
  addon_version = "v0.9.0-eksbuild.14"
  depends_on    = [aws_eks_cluster.rohit_eks]
}

resource "aws_eks_addon" "external_dns" {
  cluster_name  = aws_eks_cluster.rohit_eks.name
  addon_name    = "external-dns"
  addon_version = "v0.23.0-eksbuild.3"
  depends_on    = [aws_eks_cluster.rohit_eks]
}