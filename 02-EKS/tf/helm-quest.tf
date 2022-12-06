resource "helm_release" "quest" {
  depends_on = [module.eks]
  name             = "quest"
  chart            = "quest"
  repository       = "../helm"
  namespace        = "default"
  create_namespace = false
  cleanup_on_fail  = true

  set {
    name  = "certificateArn"
    value = aws_acm_certificate.quest.arn
  }
}
