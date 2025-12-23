variable "region" {
  description = "AWS Region to deploy resources"
  type        = string
}

variable "project_name" {
  description = "Project name prefix for tagging resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_1" {
  description = "CIDR block for Public Subnet 1 (Master Node)"
  type        = string
}

variable "public_subnet_2" {
  description = "CIDR block for Public Subnet 2 (Future Use/HA)"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type (Free Tier: t2.micro or t3.micro)"
  type        = string
}

variable "public_key_path" {
  description = "Path to the public SSH key on your local machine"
  type        = string
}

variable "private_key_path" {
  description = "Path to the private SSH key on your local machine"
  type        = string
  
}