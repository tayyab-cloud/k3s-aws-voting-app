variable "region" {
  description = "AWS Region to deploy resources"
  type        = string

}

variable "project_name" {
  description = "Project name prefix for tagging resources"
  type        = string
  default = "k3s-voting-app"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default = "10.0.0.0/16"
}

variable "public_subnet_1" {
  description = "CIDR block for Public Subnet 1 (Master Node)"
  type        = string
  default = "10.0.1.0/24"
}

variable "public_subnet_2" {
  description = "CIDR block for Public Subnet 2 (Future Use/HA)"
  type        = string
  default = "10.0.2.0/24"
}

variable "instance_type" {
  description = "EC2 Instance Type (Free Tier: t2.micro or t3.micro)"
  type        = string
  default = "t2.micro"
}

variable "public_key_path" {
  description = "Path to the public SSH key on your local machine"
  type        = string
}

variable "private_key_path" {
  description = "Path to the private SSH key on your local machine"
  type        = string
  default = "~/.ssh/id_rsa"
}