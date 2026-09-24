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