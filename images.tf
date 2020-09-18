provider "google" {
  credentials = "terraform-admin.json"
  project     = var.project
  region      = var.region
}

# create node 
resource "google_compute_instance" "node" {
  name            = "node"
  can_ip_forward  = true
  machine_type    = var.machine_type
  zone            = var.zone
  tags            = var.prometheus_tags
  
  boot_disk {
    initialize_params {
	  size  = var.disk_size
	  type  = var.disk_type
	  image = var.images
    }
  }
  
  metadata_startup_script = file("node.sh")
	
  depends_on = [google_compute_subnetwork.public]
  
  network_interface {
	network    = var.network_custom_vpc
    subnetwork = var.subnetwork_custom_public
    access_config {}
  }
}

locals {
  node_ip = google_compute_instance.node.network_interface.0.network_ip
}

# create instance srv-prometheus
resource "google_compute_instance" "srv-prometheus" {
  name            = "srv-prometheus"
  can_ip_forward  = true
  machine_type    = var.machine_type
  zone            = var.zone
  tags            = var.prometheus_tags
  
  boot_disk {
    initialize_params {
	  size  = var.disk_size
	  type  = var.disk_type
	  image = var.images
    }
  }
  
  metadata_startup_script = templatefile("prometheus-srv.sh", {
    cli_node_ip = "${local.node_ip}" })
	
  depends_on = [google_compute_subnetwork.public]
  
  network_interface {
	network    = var.network_custom_vpc
    subnetwork = var.subnetwork_custom_public
    access_config {}
  }
}
