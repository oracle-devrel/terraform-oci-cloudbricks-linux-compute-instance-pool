# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# output.tf
#
# Purpose: The following file defines the output for the linux_compute_instance_pool brick

output "instance_configuration" {
  description = "Instance Configuration"
  value       = oci_core_instance_configuration.InstanceConfiguration
}


output "instance_pool" {
  description = "Instance Pool"
  value       = oci_core_instance_pool.InstancePool
}

output "instance_pool_computes" {
  description = "Computes created inside instance pool"
  value       = data.oci_core_instance_pool_instances.POOLINSTANCES.*.instances
}

output "instance_pool_computes_instances" {
  value = data.oci_core_instance_configurations.INSTANCECONFIGURATIONS.instance_configurations
}
