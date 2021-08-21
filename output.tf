/* output.tf 
Author: DALQUINT - denny.alquinta@oracle.com
Purpose: The following script defines the output for Compute located on private network
Copyright (c) 2017, 2020, Oracle and/or its affiliates. All rights reserved. 
*/

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





