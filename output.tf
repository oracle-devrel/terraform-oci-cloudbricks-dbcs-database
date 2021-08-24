# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# output.tf
#
# Purpose: The following script defines the DBCS output when creation is completed


output "db_nodes_scan_ips" {
  value       = data.oci_core_private_ip.DBSCANIP.*.ip_address
  description = "Nodes SCAN IPs"
}


output "db_nodes_vip_info" {
  value       = zipmap(data.oci_core_private_ip.DBVIPIP.*.hostname_label, data.oci_core_private_ip.DBVIPIP.*.ip_address)
  description = "VIP hostname-IP map"
}

output "db_nodes_info" {
  value       = zipmap(data.oci_core_vnic.DBNODEVNIC.*.hostname_label, data.oci_core_vnic.DBNODEVNIC.*.private_ip_address)
  description = "DB Node hostname-IP map"
}


output "dbcs_db_system" {
  value       = oci_database_db_system.DBSystem
  description = "Database DB System instance"
  sensitive = true
}

