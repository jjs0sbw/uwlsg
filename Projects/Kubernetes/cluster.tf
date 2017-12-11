resource "google_container_cluster" "cluster" {
    name                = "uwsg-kubernetes-cluster"
    description         = "UW Study Group Kubernetes Cluster"
    zone                = "us-west1-a"
    initial_node_count  = 3
}

# The following outputs allow authentication and connectivity to the GKE Cluster.

output "client_certificate" {
  value = "${google_container_cluster.cluster.master_auth.0.client_certificate}"
}

output "client_key" {
  value = "${google_container_cluster.cluster.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.cluster.master_auth.0.cluster_ca_certificate}"
}
