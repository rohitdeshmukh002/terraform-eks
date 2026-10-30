resource "helm_release" "cluster_autoscaler" {
  name      = "cluster-autoscaler"
  namespace = "kube-system"
  chart     = "/tmp/cluster-autoscaler-9.59.0.tgz"
  version   = "9.59.0"

  values = [
    yamlencode({
      autoDiscovery = {
        clusterName = aws_eks_cluster.my_cluster.name
      }

      awsRegion     = "ap-south-1"
      cloudProvider = "aws"

      rbac = {
        serviceAccount = {
          create = true
          name   = "cluster-autoscaler"
        }
      }
    })
  ]

  depends_on = [
    aws_eks_node_group.pathnex-NG,
    aws_eks_pod_identity_association.cluster_autoscaler,
    aws_iam_role_policy_attachment.cluster_autoscaler
  ]
}