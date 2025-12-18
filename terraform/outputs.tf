output "k3s_node_ip" {
  description = "Public IP of the K3s Node"
  value       = module.compute.public_ip
}

output "ssh_command" {
  description = "Command to SSH into the instance"
  value       = "ssh -i ~/.ssh/k3s_key ubuntu@${module.compute.public_ip}"
}