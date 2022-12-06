resource "helm_release" "quest" {
  depends_on       = [google_container_node_pool.primary_nodes, helm_release.cert_manager]
  name             = "quest"
  chart            = "quest"
  repository       = "../helm"
  namespace        = "default"
  create_namespace = false
  cleanup_on_fail  = true

  set {
    name  = "email"
    value = var.email
  }
}
