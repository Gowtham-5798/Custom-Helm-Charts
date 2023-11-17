module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "my-cluster"
  cluster_version = "1.28"

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = "vpc-xxxxxxxxxxx"
  subnet_ids               = ["subnet-xxxxxxxxxxxxx", "subnet-xxxxxxxxxxxxxxxx", "subnet-xxxxxxxxxxxxxxx"]
  control_plane_subnet_ids = ["subnet-xxxxxxxxxxxxx", "subnet-xxxxxxxxxxxxxxxx", "subnet-xxxxxxxxxxxxxxx"]


  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t2.medium"]
  }

  eks_managed_node_groups = {
    gowtham = {
      min_size     = 1
      max_size     = 2
      desired_size = 2

      instance_types = ["t2.medium"]
      capacity_type  = "SPOT"
    }
  }
}

resource "helm_release" "helm" {
  name      = "my-release"
  chart     = "C:\\Users\\user\\Downloads\\Helm-Chart\\Charts"
  namespace = "default"
}

