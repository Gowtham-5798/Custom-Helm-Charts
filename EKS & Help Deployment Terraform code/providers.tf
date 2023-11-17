provider "aws" {
  region = "ap-south-1"
}

provider "helm" {
  kubernetes {
    config_path = "C:\\Users\\user\\.kube\\config"
  }
}

terraform {
  backend "s3" {
    bucket  = "terraform-example"
    key     = "my-eks-terraform-project/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}
