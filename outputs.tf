
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_version" {
  value = module.eks.cluster_version
}

output "node_group_status" {
  value = module.eks.node_group_status
}

output "worker_key_name" {
  description = "EC2 key pair attached to EKS worker nodes"
  value       = aws_key_pair.worker.key_name
}
