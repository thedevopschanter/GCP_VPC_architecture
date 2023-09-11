# Values related to the project to be created
# project_id         = "project-vpc123-42853321"
region             = "asia-southeast1"
project_name       = "vpc-multi-tier-architecture"
billing_account_id = "01CED6-DC622D-D8CD76" # Use your billing account ID here 

# VPC network name
vpc_network_name = "my-vpc-network"

# Values for the public instance, firewall and subnet configuration
public_subnet_name            = "public-subnet"
public_cidr_range             = "10.0.0.0/24"
public_instance_name          = "public-instance"
public_instance_firewall_name = "ingress-all"
public_instance_machine_type  = "e2-micro"
public_instance_zone          = "asia-southeast1-a"
public_instance_machine_image = "centos-cloud/centos-7"

# Values for the private subnet, firewall and instance configuration
private_subnet_name            = "private-subnet"
private_cidr_range             = "10.0.1.0/24"
private_instance_name          = "private-instance"
private_instance_firewall_name = "ingress-local"
private_instance_machine_type  = "e2-micro"
private_instance_zone          = "asia-southeast1-b"
private_instance_machine_image = "centos-cloud/centos-7"