variable "cluster_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "security_grp" {
  type = string
}

variable "node_grp" {
  type = string
}

variable "node_instance_profile_name" {
  type = string
}

variable "cluster_role_arn" {
  type = string
}
