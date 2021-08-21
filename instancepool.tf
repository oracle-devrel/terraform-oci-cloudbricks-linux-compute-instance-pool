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

      dynamic "shape_config" {
        for_each = var.is_flex_shape ? [1] : []
        content {
          memory_in_gbs = var.instance_shape_config_memory_in_gbs
          ocpus         = var.instance_shape_config_ocpus
        }
      }

      dynamic "shape_config" {
        for_each = var.is_flex_shape ? [] : [1]
        content {
          ocpus = var.instance_shape_config_ocpus
        }
      }

      create_vnic_details {
        assign_public_ip       = var.assign_public_ip_flag
        display_name           = var.primary_vnic_display_name
        skip_source_dest_check = false
      }

      source_details {
        source_type = "image"
        image_id    = var.base_compute_image_ocid
      }
    }
  }
}


resource "oci_core_instance_pool" "InstancePool" {
  depends_on                = [oci_core_instance_configuration.InstanceConfiguration]
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

  dynamic "load_balancers" {
    for_each = var.is_load_balancer_required ? [1] : []
    content {
      backend_set_name = var.lbaas_bes_name
      load_balancer_id = var.load_balancer_ocid
      port             = var.lbaas_bes_checkport
      vnic_selection   = "primaryvnic"
    }
  }
}


resource "oci_autoscaling_auto_scaling_configuration" "ScheduleAutoScalingConfig" {
  count      = var.autoscaling_is_schedule ? 1 : 0
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
      initial = var.schedule_scaleout_instance_number
    }
    display_name = "scaleout"
    execution_schedule {
      expression = var.schedule_scaleout_time_window
      timezone   = "UTC"
      type       = "cron"
    }
    is_enabled  = var.schedule_is_scaleout_enabled
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
    is_enabled  = var.schedule_is_scalein_enabled
    policy_type = "scheduled"
  }
}

resource "oci_autoscaling_auto_scaling_configuration" "CPUAutoScalingConfig" {
  count      = var.autoscaling_is_cpu ? 1 : 0
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
      initial = var.pool_size
      max     = var.max_autoscale_instance_number
      min     = var.min_autoscale_instance_number
    }
    display_name = "cpuscaling"
    policy_type  = "threshold"
    rules {
      action {
        type  = "CHANGE_COUNT_BY"
        value = var.scaleout_step
      }
      display_name = "CPUAutoScaleOutRule"
      metric {
        metric_type = "CPU_UTILIZATION"
        threshold {
          operator = "GT"
          value    = var.threshold_scale_out
        }
      }
    }
    rules {
      action {
        type  = "CHANGE_COUNT_BY"
        value = -var.scalein_step
      }
      display_name = "CPUAutoScaleInRule"
      metric {
        metric_type = "CPU_UTILIZATION"
        threshold {
          operator = "LT"
          value    = var.threshold_scale_in
        }
      }
    }
  }
}


resource "oci_autoscaling_auto_scaling_configuration" "MemoryAutoScalingConfig" {
  count      = var.autoscaling_is_memory ? 1 : 0
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
      initial = var.pool_size
      max     = var.max_autoscale_instance_number
      min     = var.min_autoscale_instance_number
    }
    display_name = "memoryscaling"
    policy_type  = "threshold"
    rules {
      action {
        type  = "CHANGE_COUNT_BY"
        value = var.scaleout_step
      }
      display_name = "MemoryAutoScaleOutRule"
      metric {
        metric_type = "MEMORY_UTILIZATION"
        threshold {
          operator = "GT"
          value    = var.threshold_scale_out
        }
      }
    }
    rules {
      action {
        type  = "CHANGE_COUNT_BY"
        value = -var.scalein_step
      }
      display_name = "MemoryAutoScaleInRule"
      metric {
        metric_type = "MEMORY_UTILIZATION"
        threshold {
          operator = "LT"
          value    = var.threshold_scale_in
        }
      }
    }
  }
}
