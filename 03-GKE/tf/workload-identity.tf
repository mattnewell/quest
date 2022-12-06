module "quest-workload-identity" {
  source     = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  name       = var.base_name
  namespace  = "default"
  project_id = var.project_id
  #NOTE: These are not least-privileged and could be scoped down
  roles = ["roles/storage.admin", "roles/compute.admin", "roles/dns.admin"]
}
