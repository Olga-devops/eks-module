variable "vpc_id" {
    type = "string"
    
}
variable "subnet_ids" {
    type = "list"
    description = "– (Required) List of subnet IDs. "
}

variable "security_group_ids" {
    type = "list"
    description = "– (Optional) List of security group"
}

variable "ssh_key_location" {
    type = "string"
}

variable "cluster_name" {
    type = "string"
    description = "- (Required) Name of the EKS Cluster."
}

variable "instance_type" {
    type = "string"
}
variable "asg_max_size" {
    type = ""
}
variable "asg_min_size" {
    type = ""
}
variable "cluster_version" {
  type = "string"
  description = "- (Required) Version of the cluster."
}
#variable "s3_bucket" {}
variable "region" {
    type = "string"
}

variable "asg_desired_capacity" {
    type = ""
}
