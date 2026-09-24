variable "container_image" {
    type        = string
    description = "The container image to deploy"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "min_size" {
  description = "Minimum number of instances"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of instances"
  type        = number
  default     = 4
}

variable "desired_capacity" {
  description = "Desired number of instances"
  type        = number
  default     = 2
}

variable "name_suffix" {
  description = "Suffix for naming resources"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "The ID of the VPC for the application resources"
  type        = string
}

variable "private_subnet_ids" {
  description = "The IDs of the private subnets for application instances"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "The IDs of the public subnets for the load balancer"
  type        = list(string)
}