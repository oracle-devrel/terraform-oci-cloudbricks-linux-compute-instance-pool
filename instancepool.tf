/* compute.tf 
Author: DALQUINT - denny.alquinta@oracle.com
Purpose: The following script defines the creation of compute instances based on an image available within the region
Copyright (c) 2020, Oracle and/or its affiliates. All rights reserved. 
*/


resource "oci_core_instance_configuration" "InstanceConfiguration" {
  compartment_id = local.compartment_id
  display_name   = var.instance_configuration_display_name

  instance_details {
    instance_type = "compute"

    launch_details {
      compartment_id               = local.compartment_id
      shape                        = var.instance_config_shape
      display_name                 = var.instance_display_name_base
      preferred_maintenance_action = var.maintainance_action
      launch_mode                  = var.launch_mode

      launch_options {
        network_type = var.network_type
      }

      shape_config {
        ocpus = var.ocpus
      }

      create_vnic_details {
        assign_public_ip       = var.assign_public_ip_flag
        display_name           = var.primary_vnic_display_name
        skip_source_dest_check = false
      }

      source_details {
        source_type = "image"
        image_id    = var.instance_image_ocid
      }

    }
  }

}



resource "oci_core_instance_pool" "InstancePool" {
  depends_on = [oci_core_instance_configuration.InstanceConfiguration]
  compartment_id            = local.compartment_id
  instance_configuration_id = oci_core_instance_configuration.InstanceConfiguration.id
  size                      = var.pool_size
  state                     = "RUNNING"
  display_name              = var.compute_display_name_base

  dynamic "placement_configurations" {
    for_each = var.compute_availability_domain_map
    content {
      availability_domain = placement_configurations.value
      fault_domains       = var.fault_domain_list      
      primary_subnet_id   = local.subnet_ocid
    }
  }

  load_balancers {
    backend_set_name = var.lbaas_bes_name
    load_balancer_id = var.load_balancer_ocid
    port             = var.lbaas_bes_checkport
    vnic_selection   = "primaryvnic"
  }


}


resource "oci_autoscaling_auto_scaling_configuration" "AutoScalingConfig" {
  depends_on = [oci_core_instance_pool.InstancePool]
  auto_scaling_resources {
    id   = oci_core_instance_pool.InstancePool.id
    type = "instancePool"
  }
  compartment_id       = local.compartment_id
  cool_down_in_seconds = "300"
  display_name         = var.autoscaling_config_display_name
  is_enabled           = var.is_autoscaling_enabled

  policies {
    capacity {
      initial = var.scaleout_instance_number
    }
    display_name = "scaleout"
    execution_schedule {
      expression = var.schedule_scaleout_time_window
      timezone   = "UTC"
      type       = "cron"
    }
    is_enabled  = var.is_scaleout_enabled
    policy_type = "scheduled"
  }
  policies {
    capacity {
      initial = var.pool_size
    }
    display_name = "scalein"
    execution_schedule {
      expression = var.schedule_scalein_time_window
      timezone   = "UTC"
      type       = "cron"
    }
    is_enabled  = var.is_scalein_enabled
    policy_type = "scheduled"
  }
}