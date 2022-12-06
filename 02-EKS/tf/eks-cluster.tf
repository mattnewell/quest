module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.31.2"

  cluster_name    = var.base_name
  cluster_version = "1.24"

  vpc_id     = aws_vpc.quest.id
  subnet_ids = aws_subnet.private.*.id

  create_node_security_group = false

  eks_managed_node_group_defaults = {
    ami_type                              = "AL2_x86_64"
    attach_cluster_primary_security_group = true
  }

  eks_managed_node_groups = {
    node_group = {
      name = "node-group-1"

      instance_types = ["t2.micro"]

      min_size     = 3
      max_size     = 5
      desired_size = 4
    }
  }
}
