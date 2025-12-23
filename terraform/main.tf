

# 1. Create Key Pair Globally (Once)
resource "aws_key_pair" "k3s_auth" {
  key_name   = "${var.project_name}-key"
  public_key = file(var.public_key_path)
}

# 2. Call VPC Module
module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidr_1 = var.public_subnet_1
  public_subnet_cidr_2 = var.public_subnet_2
  project_name         = var.project_name
}

# 3. Call Security Module
module "security" {
  source       = "./modules/security"
  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
}

# 4. Call Compute Module
module "compute" {
  source            = "./modules/compute"
  # We do NOT pass AMI ID anymore. The module will find it.
  instance_type     = var.instance_type
  subnet_id         = module.vpc.public_subnet_id
  security_group_id = module.security.security_group_id
  
  # Pass the Key Name we created above
  key_name          = aws_key_pair.k3s_auth.key_name
  
  project_name      = var.project_name
}

# Generate Ansible Inventory File
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.tftpl", {
    public_ip = module.compute.public_ip

    private_key_path  = var.private_key_path
  })
  filename = "${path.module}/../ansible/inventory/hosts.ini"
}