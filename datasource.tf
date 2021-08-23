# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# datasource.tf
#
# Purpose: The following script defines the lookup logic used in code to obtain pre-created or JIT-created resources in tenancy.

data "oci_identity_availability_domain" "AD" {
  compartment_id = var.tenancy_ocid
  ad_number      = var.dbcs_availability_domain_number
}

data "oci_identity_compartments" "COMPARTMENTS" {
  compartment_id            = var.tenancy_ocid
  compartment_id_in_subtree = true
  filter {
    name   = "name"
    values = [var.dbcs_instance_compartment_name]
  }
}

data "oci_identity_compartments" "NWCOMPARTMENTS" {
  compartment_id            = var.tenancy_ocid
  compartment_id_in_subtree = true
  filter {
    name   = "name"
    values = [var.dbcs_network_compartment_name]
  }
}

data "oci_core_vcns" "VCN" {
  compartment_id = local.nw_compartment_id
}

/********** Subnet Accessors **********/

data "oci_core_subnets" "SUBNET" {
  compartment_id = local.nw_compartment_id
  vcn_id         = local.vcn_id
  filter {
    name   = "display_name"
    values = [var.network_subnet_name]
  }
}


/********** Datasource Lookup Accessors **********/
data "oci_database_db_nodes" "DBNODELIST" {
  compartment_id = local.compartment_id
  db_system_id   = oci_database_db_system.DBSystem.id
}

data "oci_database_db_node" "DBNODEDETAILS" {
  count      = var.node_count
  db_node_id = lookup(data.oci_database_db_nodes.DBNODELIST.db_nodes[count.index], "id")
}

data "oci_core_vnic" "DBNODEVNIC" {
  count      = var.node_count
  vnic_id    = data.oci_database_db_node.DBNODEDETAILS[count.index].vnic_id
  depends_on = [data.oci_database_db_node.DBNODEDETAILS]
}

data "oci_core_private_ip" "DBSCANIP" {
  count         = var.node_count > 1 ? 3 : 0
  private_ip_id = oci_database_db_system.DBSystem.scan_ip_ids[count.index]
}

data "oci_core_private_ip" "DBVIPIP" {
  count         = var.node_count > 1 ? var.node_count : 0
  private_ip_id = oci_database_db_system.DBSystem.vip_ids[count.index]
}




locals {


  /********** Backup windows definitions and Local Accessor **********/

  backup_windows_defs = { "12:00AM-02:00AM_UTC" = "SLOT_ONE",
    "02:00AM-04:00AM_UTC" = "SLOT_TWO",
    "04:00AM-06:00AM_UTC" = "SLOT_THREE",
    "06:00AM-08:00AM_UTC" = "SLOT_FOUR",
    "08:00AM-10:00AM_UTC" = "SLOT_FIVE",
    "10:00AM-12:00AM_UTC" = "SLOT_SIX",
    "12:00PM-02:00PM_UTC" = "SLOT_SEVEN",
    "02:00PM-04:00PM_UTC" = "SLOT_EIGHT",
    "04:00PM-06:00PM_UTC" = "SLOT_NINE",
    "06:00PM-08:00PM_UTC" = "SLOT_TEN",
    "08:00PM-10:00PM_UTC" = "SLOT_ELEVEN",
    "10:00PM-12:00AM_UTC" = "SLOT_TWELVE"
  }

  # Subnet OCID local accessors
  subnet_ocid        = length(data.oci_core_subnets.SUBNET.subnets) > 0 ? data.oci_core_subnets.SUBNET.subnets[0].id : null
  auto_backup_window = lookup(local.backup_windows_defs, var.auto_backup_window_utc, null)

  # Compartment OCID Local Accessors
  compartment_id      = lookup(data.oci_identity_compartments.COMPARTMENTS.compartments[0], "id")
  nw_compartment_id   = lookup(data.oci_identity_compartments.NWCOMPARTMENTS.compartments[0], "id")
  availability_domain = data.oci_identity_availability_domain.AD.name
  
  # VCN OCID Local Accessor 
  vcn_id = data.oci_core_vcns.VCN.virtual_networks[0].id
}