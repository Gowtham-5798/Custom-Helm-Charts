provider "aws" {
  region = "ap-south-1"
}

# You can either follow way-1 or way-2 to deploy the helm
# way-1
provider "helm" {
  kubernetes {
    config_path = "C:\\Users\\user\\.kube\\config"
  }
}

# way-2
data "aws_eks_cluster" "eks_cluster" {
  depends_on = [module.eks]
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "aws_cluster_auth" {
  depends_on = [module.eks]
  name = module.eks.cluster_name
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.eks_cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.aws_cluster_auth.token
  }
}

output "eks_cluster_endpoint" {
  value = data.aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_ca_certificate" {
  value = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority.0.data)
}

output "eks_cluster_token" {
  value = data.aws_eks_cluster_auth.aws_cluster_auth.token
  sensitive = true
}

terraform {
  backend "s3" {
    bucket  = "terraform-example"
    key     = "my-eks-terraform-project/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}
