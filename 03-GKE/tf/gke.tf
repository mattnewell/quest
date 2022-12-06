resource "google_container_cluster" "quest" {
  name     = var.base_name
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
  #NOTE: You have to set exactly this value and no other
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name     = google_container_cluster.quest.name
  location = var.region
  cluster  = google_container_cluster.quest.name
  # node_count is per location
  node_count = 2
  #TODO: Move to var
  node_locations = ["us-central1-a"]

  node_config {
    machine_type    = "e2-small"
    service_account = module.quest-workload-identity.gcp_service_account_email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
