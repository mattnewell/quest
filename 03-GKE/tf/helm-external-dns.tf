resource "helm_release" "external_dns" {
  depends_on       = [google_container_node_pool.primary_nodes]
  name             = "external-dns"
  chart            = "external-dns"
  repository       = "../helm"
  namespace        = "default"
  create_namespace = false
  cleanup_on_fail  = true

  set {
    name  = "provider"
    value = "google"
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = module.quest-workload-identity.k8s_service_account_name
  }
}
