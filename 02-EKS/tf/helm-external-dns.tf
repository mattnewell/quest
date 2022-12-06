resource "helm_release" "external_dns" {
  depends_on = [module.eks]
  name             = "external-dns"
  chart            = "external-dns"
  repository       = "https://charts.bitnami.com/bitnami"
  namespace        = "kube-system"
  create_namespace = false
  cleanup_on_fail  = true

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }
}
