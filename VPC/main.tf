# Creating a new Project to create and manage the infrastructure
resource "google_project" "project_vpc" {
  name            = var.project_name
  project_id      = var.project_id
  billing_account = var.billing_account_id
}

# Using a provider block here to specify the above created project to use
# Configuring the provider to work with the project created above
provider "google" {
  region  = var.region
  project = var.project_id
}

# Enabling Google Compute Service APis
resource "google_project_service" "enable_APIs" {
  project = google_project.project_vpc.project_id
  service = "compute.googleapis.com"

}

# Waiting for enablement of required APIS before creating VPC network
resource "time_sleep" "wait_for_API_enablement" {
  create_duration = "150s"

  depends_on = [
  google_project_service.enable_APIs]
}

# Creating the VPC network
resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_network_name
  auto_create_subnetworks = false

  depends_on = [
    time_sleep.wait_for_API_enablement
  ]

}

# Creating a public subnet in the VPC network
resource "google_compute_subnetwork" "public_subnet" {
  name          = var.public_subnet_name
  ip_cidr_range = "10.0.0.0/24"
  network       = google_compute_network.vpc_network.self_link
  region        = "asia-southeast1"

  depends_on = [
  google_compute_network.vpc_network]
}

# Creating a private subnet in the VPC network
resource "google_compute_subnetwork" "private_subnet" {
  name          = var.private_subnet_name
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.vpc_network.self_link
  region        = "asia-southeast1"

  depends_on = [
  google_compute_network.vpc_network]
}

# Cerating a public firewall to allow all incoming traffic to public instances
resource "google_compute_firewall" "ingress_all" {
  name    = var.public_instance_firewall_name
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["public-instance"]
}

# Creating a private firewall to allow only local traffic in the instance
resource "google_compute_firewall" "ingress_local" {
  name    = var.private_instance_firewall_name
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = ["10.0.0.0/16"]
  target_tags   = ["private-instance"]
}

# Creating a public instance in the public subnet 
resource "google_compute_instance" "public_instance" {
  name         = var.public_instance_name
  machine_type = var.public_instance_machine_type
  zone         = var.public_instance_zone

  boot_disk {
    initialize_params {
      image = var.public_instance_machine_image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.public_subnet.self_link

    access_config {
      # Ephemeral IP will be assigned
    }
  }

  tags = ["public-instance"]

}

# Creating a private instance in the private subnet 
resource "google_compute_instance" "private_instance" {
  name         = var.private_instance_name
  machine_type = var.private_instance_machine_type
  zone         = var.private_instance_zone

  boot_disk {
    initialize_params {
      image = var.private_instance_machine_image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.private_subnet.self_link
  }
  # No access config block, so no public IP will be assigned

  tags = ["private-instance"]
}
