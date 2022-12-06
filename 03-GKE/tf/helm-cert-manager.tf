resource "helm_release" "cert_manager" {
  depends_on       = [google_container_node_pool.primary_nodes]
  name             = "cert-manager"
  chart            = "cert-manager"
  repository       = "https://charts.jetstack.io"
  namespace        = "default"
  create_namespace = false
  cleanup_on_fail  = true

  set {
    name  = "installCRDs"
    value = true
  }
}
