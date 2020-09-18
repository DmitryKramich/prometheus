project       = "compact-retina-288017"
region        = "us-central1"
zone          = "us-central1-c"
machine_type  = "custom-1-4608"
disk_type     = "pd-ssd"
disk_size     = 30
images        = "centos-cloud/centos-7"

#network options 
student_name          = "dk"
external_http_ports   = ["80","443","8080"]
ssh_external_ports    = ["22"]
external_ranges       = ["0.0.0.0/0"]
prometheus_tcp_ports  = ["9090","3000","9093","9115","9100"]
internal_ranges       = ["10.2.0.0/24"]
public_subnet         = "10.2.1.0/24"
prometheus_tags       = ["prometheus"]

network_custom_vpc        = "dk-vpc"
subnetwork_custom_public  = "public-subnet"



