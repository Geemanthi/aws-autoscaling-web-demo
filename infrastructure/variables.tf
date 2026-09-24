variable "env" {
    type        = string
    description = "The environment to deploy"
}

variable "vpc_cidr_block" {
    type        = string
    description = "The CIDR block for the VPC"
}

variable "region_code" {
    type        = string
    description = "The AWS region code"
}

variable "organization" {
    type        = string
    description = "The organization name"
}

variable "project" {
    type        = string
    description = "The project name"
}

variable "private_subnets" {
    type        = map(string)
    description = "A map of private subnets with availability zones and CIDR block"
}

variable "public_subnets" {
    type        = map(string)
    description = "A map of public subnets with availability zones and CIDR blocks"
}

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
