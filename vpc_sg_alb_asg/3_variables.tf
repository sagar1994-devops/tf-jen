variable "environment" {
  type        = string
  default     = "Dev"
  description = "The project environment,such as Dev,Staging,or Production"
}

variable "aws_region" {
  type        = string
  default     = "us-east-2"
  description = "The AWS region where the resources will be deployed."
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "The CIDR block for the VPC"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
  description = "The CIDR block for the public subnets in Availability Zone 1,2"
}


variable "private_subnet_cidrs" {
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.3.0/24"]
  description = "The CIDR block for the private subnets in Availability Zone 1,2"
}

variable "azs" {
  type    = list(string)
  default = ["us-east-2a", "us-east-2b"]
}

variable "ami_id" {
  type    = string
  default = "ami-0ea3c35c5c3284d82"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "newkey"
}

variable "desired_capacity" {
  type    = number
  default = 2
}

variable "max_size" {
  type    = number
  default = 4
}

variable "min_size" {
  type    = number
  default = 2
}
