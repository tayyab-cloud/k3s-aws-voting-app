terraform {
  backend "s3" {
    bucket         = "haider-k3s-terraform-state"  
    key            = "devops-project/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}