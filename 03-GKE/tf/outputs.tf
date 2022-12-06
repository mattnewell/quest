output "kubernetes_cluster_name" {
  value = google_container_cluster.quest.name
}

output "region" {
  value = var.region
}

output "global_ip" {
  value = google_compute_global_address.quest.address
}
