
module "vpc" {
  source = "./modules/vpc"

  project_name         = var.project_name
  cluster_name         = var.cluster_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "iam" {
  source = "./modules/iam"

  project_name = var.project_name
  cluster_name = var.cluster_name
}

resource "aws_key_pair" "worker" {
  key_name   = "${var.cluster_name}-worker"
  public_key = file("${path.module}/keys/rohit-eks-worker.pub")
}

module "eks" {
  source = "./modules/eks"

  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version
  worker_key_name    = aws_key_pair.worker.key_name

  subnet_ids = module.vpc.private_subnet_ids

  cluster_role_arn = module.iam.cluster_role_arn
  node_role_arn    = module.iam.node_role_arn

  cluster_endpoint_public_access_cidrs = (
    var.cluster_endpoint_public_access_cidrs
  )

  instance_types = var.instance_types
  desired_size   = var.desired_size
  min_size       = var.min_size
  max_size       = var.max_size

  depends_on = [module.iam]
}
