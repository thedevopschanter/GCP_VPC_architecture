# Variables related to the project to be created
variable "project_id" {
  type        = string
  description = "The ID of the project that will be created"
}
variable "region" {
  type        = string
  description = "The region in which the VPC would be created"
}
variable "project_name" {
  type        = string
  description = "The Name of the Google Project that will be created"
}
variable "billing_account_id" {
  type        = string
  description = "The ID of the billing account to which the created project will be linked to"
}
#################

# Varible for VPC network name
variable "vpc_network_name" {
  type        = string
  description = "Name of your VPC network"
}
#################

# Variables realted to public subnet, firewall and instances
variable "public_subnet_name" {
  type        = string
  description = "Name of the public subnet"
}
variable "public_cidr_range" {
  type        = string
  description = "The IP range of the public CIDR"
}
variable "public_instance_name" {
  type        = string
  description = "Name of the public instance launched in the public subnet"
}
variable "public_instance_firewall_name" {
  type        = string
  description = "Name of the public firewall to create all traffic"
}
variable "public_instance_machine_type" {
  type        = string
  description = "The machine type of the public instance"
}
variable "public_instance_zone" {
  type        = string
  description = "The zone in which the public isntance would be launched"
}
variable "public_instance_machine_image" {
  type        = string
  description = "The image for the public instance"
}
#################

# Varibles related to private subnet, firewall and instances
variable "private_subnet_name" {
  type        = string
  description = "Name of the private subnet"
}
variable "private_cidr_range" {
  type        = string
  description = "The IP range of the public CIDR"
}
variable "private_instance_name" {
  type        = string
  description = "Name of the private instance launched in the private subnet"
}
variable "private_instance_firewall_name" {
  type        = string
  description = "Name of the private firewall to allow only internal traffic"
}
variable "private_instance_machine_type" {
  type        = string
  description = "The machine type of the private instance"
}
variable "private_instance_zone" {
  type        = string
  description = "The zone in which the private isntance would be launched"
}
variable "private_instance_machine_image" {
  type        = string
  description = "The image for the private instance"
}
