# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# variables.tf 
#
# Purpose: The following file declares all variables used in this backend repository

/********** Provider Variables NOT OVERLOADABLE **********/
variable "region" {
  description = "Target region where artifacts are going to be created"
}

variable "tenancy_ocid" {
  description = "OCID of tenancy"
}

variable "user_ocid" {
  description = "User OCID in tenancy"
}

variable "fingerprint" {
  description = "API Key Fingerprint for user_ocid derived from public API Key imported in OCI User config"
}

variable "ssh_public_is_path" {
  description = "Describes if SSH Public Key is located on file or inside code"
  default     = false
}

variable "ssh_private_is_path" {
  description = "Describes if SSH Private Key is located on file or inside code"
  default     = false
}

variable "ssh_public_key" {
  description = "Defines SSH Public Key to be used in order to remotely connect to compute instance"
  type        = string
}
variable "private_key_path" {
  description = "Private Key Absolute path location where terraform is executed"
}
/********** Provider Variables NOT OVERLOADABLE **********/

/********** Brick Variables **********/

/********** DBCS Variables **********/

variable "storage_management" {
  description = "The storage option used in DB system. ASM - Automatic storage management LVM - Logical Volume management"
  default     = "ASM"
}


variable "ssh_private_key" {
  description = "Private Key to use for latter connection to the DB on null resource"
}


variable "cluster_name" {
  description = "Describes the DB Cluster Name"
  default     = "DB-Cluster"
}

variable "db_admin_password" {
  description = "DBCS Administration Password"
}

variable "db_name" {
  description = "Database Name"
}

variable "character_set" {
  description = "Charset used by DB"
}

variable "n_character_set" {
  description = "N Charset used by DB"
}

variable "db_workload" {
  description = "Workload intended from DB"
}

variable "db_version" {
  description = "Database Version"
}

variable "db_display_name" {
  description = "Database Display Name"
}

variable "db_home_display_name" {
  description = "Database Home Display Name"
}

variable "db_disk_redundancy" {
  description = "Database Disk Redundancy"
}

variable "db_system_shape" {
  description = "DB Systems Shape"
}

variable "hostname" {
  description = "DB Hostname"
}

variable "data_storage_size_in_gb" {
  description = "Database Storage in GB"
}

variable "db_edition" {
  description = "Database Edition"
}

variable "license_model" {
  description = "Database System License Model"
}

variable "node_count" {
  description = "Amount of nodes in DB"
}

variable "fault_domains" {
  description = "Fault Domains"
  default     = ""
}

variable "time_zone" {
  description = "Timezone definition for Database"
  default     = "America/Santiago"

}

variable "pdb_name" {
  description = "Pluggable Database Name for DB"
}

variable "dbcs_availability_domain_number" {
  description = "Defines the availability domain where OCI artifact will be created. This is a numeric value greater than 0"
}

variable "auto_backup_enabled" {
  description = "Defines if autobackup is enabled or not"
  default     = false
}

variable "recovery_window_in_days" {
  description = "Defines the recovery window in days. Supported values are 7,15,30,45 and 60 days"
  default     = null
}

variable "auto_backup_window_utc" {
  description = "Defines the recovery 2 hour window. The values must be from '12:00AM-02:00AM_UTC' to '10:00PM-12:00AM_UTC', if different value is provided defaults to null (ANYTIME) "
  default     = "ANYTIME"
}

variable "database_software_image_id" {
  description = "Defines the OCID of the Database Software Image that should be used by database"
  default     = null
}

/********** DBCS Variables **********/

/********** Datasource and Subnet Lookup related variables **********/

variable "dbcs_instance_compartment_name" {
  description = "Defines the compartment name where the infrastructure will be created"
  default     = ""
}

variable "dbcs_instance_compartment_id" {
  description = "Defines the compartment OCID where the infrastructure will be created"
  default     = ""
}

variable "dbcs_network_compartment_name" {
  description = "Defines the compartment where the Network is currently located"

}

variable "network_subnet_name" {
  description = "Defines the subnet display name where this resource will be created at"
}

variable "vcn_display_name" {
  description = "VCN Display name to execute lookup"
}

/********** Datasource related variables **********/

/********** Brick Variables **********/
