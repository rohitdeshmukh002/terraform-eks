
variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "worker_key_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "cluster_role_arn" {
  type = string
}

variable "node_role_arn" {
  type = string
}

variable "cluster_endpoint_public_access_cidrs" {
  type = list(string)
}

variable "instance_types" {
  type = list(string)
}

variable "desired_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}
