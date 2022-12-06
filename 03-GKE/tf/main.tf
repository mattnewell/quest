provider "google" {
  project = var.project_id
  region  = var.region
}

# Retrieve an access token as the Terraform runner
data "google_client_config" "provider" {}

data "google_container_cluster" "quest" {
  name     = google_container_cluster.quest.name
  location = var.region
}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.quest.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.quest.master_auth[0].cluster_ca_certificate,
  )
}

provider "helm" {
  kubernetes {
    host  = "https://${data.google_container_cluster.quest.endpoint}"
    token = data.google_client_config.provider.access_token
    cluster_ca_certificate = base64decode(
      data.google_container_cluster.quest.master_auth[0].cluster_ca_certificate,
    )
  }
}
