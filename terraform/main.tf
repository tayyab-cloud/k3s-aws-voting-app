

# 1. Create Key Pair Globally (Once)
resource "aws_key_pair" "k3s_auth" {
  key_name   = "k3s-key-hardcoded-v1"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCvgFKk62TDZpe5eiPfN2oAxb7+sfuzY8ZOrhPPHh1jmaAC3DF7kdgm34WBu5i8nTBTgArpTRGJEA13p4oPqQXXlmMqQ0ohYttc/eD13ujbOgBcMvijAm5k/U2ehJ5n8j1CnQg5xtYLz5+xG2AQ0fhnfF8MTFvaaBcYB9QAmpEcLrDj4O1tRtmuhbwzn7B1nJOE96Xy8uNkV8KB2lf3QRrzHFJiusOrPJqKsYaNQc7I9TFYIK6O5RYg1VhVGT7kKhIhHE5NLAJFgAgXnKzJun6DvjTy44mw17Lkbyt4GOS4CwuqlQAUkUpNx1km+NH27OkX+DG/SjsCdOPQKbuB+LIdQhcn+nz6LZzWfe74Hgy0kET0zOSgP5TlPEhShXj3yrQalVfVXgolaKGm3dHjXcovNTuIyP01LPhvtwFd55iCrxS69NarQMTlzt14B468G8ZdiX4yVJvaPQ9kkABWSga4VCeJDf99Z5fFo9/EUSQgpDk3Q9RbLl/9jgPaBqHT28WGy7W50Xl2g/E5sFJLesaS6W10szcvKAOhFBRlSyC8MfvwPPV7xfbdqq0Mp4rYvc2XcfHRum0213L8xUyvkZ3in2B8Ssgv9+9EqPpccG8QMyGKapc6KowgK6ZOsxSTLfOuOhQJVDMzHehBHAMEP3KcqcMTROue81dE26eyioHbqQ== k3s-user"
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