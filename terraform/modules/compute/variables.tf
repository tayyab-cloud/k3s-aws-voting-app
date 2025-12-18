
variable "instance_type" {
    description = "The type of EC2 instance to launch"
}
variable "subnet_id" {
    description = "The subnet ID where the EC2 instance will be launched"
}
variable "security_group_id" {
    description = "The security group ID to associate with the EC2 instance"
}
variable "project_name" {
    description = "The name of the project"
}

# NEW: Receive the key name from root
variable "key_name" {
    description = "The name of the key pair to use for the EC2 instance"
}