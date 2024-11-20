variable "tags" {
  description = "A map of tags to assign to resources, providing identification and metadata."
}

variable "env" {
  description = "The environment in which the ALB will be deployed, e.g., 'dev', 'staging', or 'production'."
}

variable "internal" {
  description = "Specify whether the ALB is internal (private subnets) or external (public subnets)."
}

variable "load_balancer_type" {
  description = "The type of load balancer to create, e.g., 'application' for ALB."
}

variable "vpc_id" {
  description = "The ID of the VPC where the ALB will be deployed."
}

variable "cidr_block" {
  description = "A list of CIDR blocks allowed to access the ALB on the specified security group port."
}

variable "sg_port" {
  description = "The port number to allow inbound traffic to the ALB, such as 80 or 443."
}

variable "subnets" {
  description = "A list of subnets in which to deploy the ALB. Use public subnets for an external ALB or private subnets for an internal ALB."
}

variable "acm" {
  description = "Provide the Certificate ARN"
}