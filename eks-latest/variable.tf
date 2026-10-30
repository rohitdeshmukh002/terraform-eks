variable "aws_region" {
  description = "aws deafult region"
  default     = "ap-south-1"
}

variable "cluster_name" {
  default = "rohit-eks"
}

variable "upgrade_policy" {
  default = "STANDARD"
}

variable "security_group_ids" {
  default = "sg-060c79da774aadc47"
}

variable "public_access_cidrs" {
  default = "0.0.0.0/0"
}

variable "subnet_ids" {
  type = list(string)

  default = [
    "subnet-0a72bd2c4d45ccb3d",
    "subnet-04f2022a8e6c79cd9",
    "subnet-04d8c5f3617bae491"
  ]
}

variable "node_group_name" {
  default = "eks-ng"
}

variable "cluster_version" {
  default = "1.36"
}

variable "ami_type" {
  default = "AL2023_x86_64_STANDARD"
}

variable "instance_type" {
  default = "t3.small"
}

variable "key_name" {
  default = "eks-key"
}