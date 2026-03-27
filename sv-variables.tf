variable "region" {
  default = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_newbits" {
  description = "Number of additional bits for subnetting"
  type        = number
  default     = 8
}