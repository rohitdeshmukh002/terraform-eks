# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

provider "helm" {
  kubernetes = {
    host = aws_eks_cluster.rohit_eks.endpoint
    cluster_ca_certificate = base64decode(
      aws_eks_cluster.my_cluster.certificate_authority[0].data
    )

    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"

      args = [
        "eks",
        "get-token",
        "--cluster-name",
        aws_eks_cluster.my_cluster.name,
        "--region",
        "ap-south-1"
      ]
    }
  }
}