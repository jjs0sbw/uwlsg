resource "google_container_cluster" "uwsg-k8s" {
    name        = "uwsg-kubernetes-cluster"
    description = "UW Study Group Kubernetes Cluster"
    zone        = "us-west1-a"

    node_pool = {
        name = "uwsg-kubernetes-nodepool"
        management = {
            auto_upgrade = true
            auto_repair = false
        }
        autoscaling = {
            min_node_count = 3
            max_node_count = 4
        }
        node_config = {
            machine_type = "n1-standard-2"
            image_type = "COS"
            disk_size_gb = 100

            oauth_scopes = [
                "https://www.googleapis.com/auth/compute",
                "https://www.googleapis.com/auth/devstorage.read_only",
                "https://www.googleapis.com/auth/logging.write",
                "https://www.googleapis.com/auth/monitoring",
                "https://www.googleapis.com/auth/servicecontrol",
                "https://www.googleapis.com/auth/service.management.readonly",
                "https://www.googleapis.com/auth/trace.append"
            ]
        }
    }
}

# The following outputs allow authentication and connectivity to the GKE Cluster.

output "client_certificate" {
  value = "${google_container_cluster.uwsg-k8s.master_auth.0.client_certificate}"
}

output "client_key" {
  value = "${google_container_cluster.uwsg-k8s.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.uwsg-k8s.master_auth.0.cluster_ca_certificate}"
}
