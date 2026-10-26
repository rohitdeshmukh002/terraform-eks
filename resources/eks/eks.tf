resource "aws_eks_cluster" "my_cluster" {
  name = "argo-cluster"
  role_arn = "arn:aws:iam::034971967372:role/AmazonEKSClusterRole"
  version = "1.36"

  upgrade_policy {
    support_type = "STANDARD"
  }

  vpc_config {
    subnet_ids = [
        "subnet-0a72bd2c4d45ccb3d",
        "subnet-04f2022a8e6c79cd9",
        "subnet-04d8c5f3617bae491"
    ]

    security_group_ids = [
        "sg-060c79da774aadc47"
    ]

    endpoint_public_access  = true
    endpoint_private_access = true

    public_access_cidrs = [
      "0.0.0.0/0"
    ]
  }
    zonal_shift_config {
        enabled = false
    }
}