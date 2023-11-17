provider "aws" {
  region = "ap-south-1"
}

provider "helm" {
  kubernetes {
    config_path = "C:\\Users\\gowth\\.kube\\config"
  }
}

terraform {
  backend "s3" {
    bucket  = "terraform-stovl"
    key     = "my-eks-terraform-project/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}