
variable "private_subnets" {
    type        = map(string)
    description = "A map of private subnets with availability zones and CIDR block"
}

variable "public_subnets" {
    type        = map(string)
    description = "A map of public subnets with availability zones and CIDR blocks"
}

variable "name_suffix" {
    type        = string
    description = "A suffix to append to resource names for uniqueness"
}

variable "tags" {
    type        = map(string)
    description = "A map of tags to apply to resources"
    default     = {}
}

variable "vpc_cidr_block" {
    type        = string
    description = "The CIDR block for the VPC"
}