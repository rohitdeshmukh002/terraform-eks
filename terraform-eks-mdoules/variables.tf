
variable "aws_region" {
  type        = string
  description = "AWS deployment region"
  default     = "ap-south-1"
}

variable "project_name" {
  type        = string
  description = "Prefix used for resource names"
  default     = "rohit-eks"
}

variable "environment" {
  type        = string
  description = "Deployment environment"
  default     = "dev"
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
  default     = "rohit-eks-dev"
}

variable "kubernetes_version" {
  type        = string
  description = "EKS Kubernetes minor version"
  default     = "1.37"
}

variable "cluster_endpoint_public_access_cidrs" {
  type        = list(string)
  description = "Public IPv4 CIDRs allowed to access the Kubernetes API"

  validation {
    condition = (
      length(var.cluster_endpoint_public_access_cidrs) > 0 &&
      alltrue([
        for cidr in var.cluster_endpoint_public_access_cidrs :
        cidr != "0.0.0.0/0"
      ])
    )
    error_message = "Provide at least one restricted CIDR. Do not allow the Kubernetes API from every IPv4 address."
  }
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR range for the VPC"
  default     = "10.20.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR ranges for public subnets"
  default     = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR ranges for private subnets"
  default     = ["10.20.11.0/24", "10.20.12.0/24"]
}

variable "instance_types" {
  type        = list(string)
  description = "EC2 instance types for worker nodes"
  default     = ["t3.medium"]
}

variable "desired_size" {
  type        = number
  description = "Desired worker node count"
  default     = 1
}

variable "min_size" {
  type        = number
  description = "Minimum worker node count"
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Maximum worker node count"
  default     = 1
}
