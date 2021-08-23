# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# dbcs.tf
#
# Purpose: The following script defines the DBCS artifact creation
# Registry: https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/database_db_system

resource "oci_database_db_system" "DBSystem" {
  availability_domain = data.oci_identity_availability_domain.AD.name
  compartment_id      = local.compartment_id
  database_edition    = var.db_edition
  cluster_name        = var.cluster_name
  fault_domains       = var.fault_domains

  db_home {
    database {
      admin_password             = var.db_admin_password
      db_name                    = var.db_name
      character_set              = var.character_set
      ncharacter_set             = var.n_character_set
      db_workload                = var.db_workload
      pdb_name                   = var.pdb_name
      database_software_image_id = var.database_software_image_id

      db_backup_config {
        auto_backup_enabled     = var.auto_backup_enabled
        auto_backup_window      = local.auto_backup_window
        recovery_window_in_days = var.recovery_window_in_days
      }
    }
    db_version                 = var.db_version
    display_name               = var.db_home_display_name
    database_software_image_id = var.database_software_image_id

  }

  disk_redundancy         = var.db_disk_redundancy
  shape                   = var.db_system_shape
  subnet_id               = local.subnet_ocid
  ssh_public_keys         = var.ssh_public_is_path ? [file(var.ssh_public_key)] : [var.ssh_public_key]
  display_name            = var.db_display_name
  hostname                = var.hostname
  data_storage_size_in_gb = var.data_storage_size_in_gb
  license_model           = var.license_model
  node_count              = var.node_count
  time_zone               = var.time_zone
  db_system_options {

    storage_management = var.storage_management
  }
}