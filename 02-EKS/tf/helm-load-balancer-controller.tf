resource "helm_release" "load_balancer_controller" {
  depends_on = [module.eks]
  name             = "load-balancer-controller"
  chart            = "aws-load-balancer-controller"
  repository       = "https://aws.github.io/eks-charts"
  namespace        = "kube-system"
  create_namespace = false
  cleanup_on_fail  = true

  set {
    name  = "clusterName"
    value = "quest-eks"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.load_balancer_controller_irsa_role.iam_role_arn
  }
}
