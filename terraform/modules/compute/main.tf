# 1. Dynamic AMI Lookup (Fetch latest Ubuntu 22.04)
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (Official Ubuntu Owner ID)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# 2. Create EC2 Instance
resource "aws_instance" "node" {
  # Use the ID found by the data source above
  ami           = data.aws_ami.ubuntu.id 
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  
  # Use the key name passed from the root module
  key_name      = var.key_name
  
  vpc_security_group_ids = [var.security_group_id]

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project_name}-node"
  }
}