# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
resource "google_compute_subnetwork" "private" {
  name                     = "private"
  ip_cidr_range            = "10.0.0.0/18"
  region                   = "us-central1"
  network                  = google_compute_network.main.id
  private_ip_google_access = true
  
  #nodes will use network range from main cidr range

  secondary_ip_range {
    range_name    = "k8s-pod-range"
    ip_cidr_range = "10.48.0.0/14"  #pods will use network range from secondary cidr range
  }
  secondary_ip_range {
    range_name    = "k8s-service-range"
    ip_cidr_range = "10.52.0.0/20"   #used to assign IP's for the clusters 
  }
}

