/* variables.tf 
Author: DALQUINT - denny.alquinta@oracle.com
Purpose: The following script declares all variables used in this backend repository
Copyright (c) 2020, Oracle and/or its affiliates. All rights reserved. 
*/

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

variable "ssh_private_key" {
  description = "Private key to log into machine"

}

/********** Provider Variables NOT OVERLOADABLE **********/


/********** Instance Pool Variables **********/
variable "vcn_display_name" {
  description = "Name of the VCN where artifact is associated with"
}


variable "pool_size" {
  description = "Amount of instances to create"
}

variable "label_zs" {
  type    = list(any)
  default = ["0", ""]
}


variable "compute_display_name_base" {
  description = "Defines the compute and hostname Label for created compute"
}

variable "instance_config_shape" {
  description = "Defines the shape to be used on compute creation"
}

variable "primary_vnic_display_name" {
  description = "Defines the Primary VNIC Display Name"
  default     = "primaryvnic"
}

variable "assign_public_ip_flag" {
  description = "Defines either machine will have or not a Public IP assigned. All Pvt networks this variable must be false"
  default     = false
}

variable "instance_image_ocid" {
  description = "Defines the OCID for the OS image to be used on artifact creation. Extract OCID from: https://docs.cloud.oracle.com/iaas/images/ or designated custom image OCID created by packer"
}

variable "private_ip" {
  description = "Describes the private IP required for machine"
  default     = null
}

variable "bkp_policy_boot_volume" {
  description = "Describes the backup policy attached to the boot volume"
  default     = "gold"
}


variable "is_compute_in_hub_dmz01" {
  description = "Defines if the compute is going to be created in Hub DMZ01 Subnet"
  default     = false
}

variable "is_compute_in_hub_svc01" {
  description = "Defines if the compute is going to be created in the Hub SharedSvc01 Subnet"
  default     = false
}

variable "linux_compute_instance_compartment_name" {
  description = "Defines the compartment name where the infrastructure will be created"
  default     = ""
}

variable "linux_compute_instance_compartment_id" {
  description = "Defines the compartment OCID where the infrastructure will be created"
  default     = ""
}

variable "linux_compute_network_compartment_name" {
  description = "Defines the compartment where the Network is currently located"
}

variable "launch_mode" {
  description = "Launch mode in which the image will be executed"
  default     = "NATIVE"

}

variable "instance_configuration_display_name" {
  description = "Display name for instance configuration"
}

variable "instance_display_name_base" {
  description = "Instance base display name"
}

variable "maintainance_action" {
  description = "Instance maintainence action"
  default     = "LIVE_MIGRATE"
}

variable "instance_shape_config_memory_in_gbs" {
  description = "Memory assigned to computes in pool"
  default     = ""
}

variable "instance_shape_config_ocpus" {
  description = "OCPU assigned computes in pool"
}

variable "is_flex_shape" {
  description = "Boolean that describes if the shape is flex or not"
  default     = false
  type        = bool
}

variable "is_load_balancer_required" {
  description = "Boolean that determines if load balancer attachment is required or not"
  default     = false
  type        = bool
}

variable "fault_domain_list" {
  description = "Fault Domain List"
  type        = list(any)
  default     = ["FAULT-DOMAIN-1", "FAULT-DOMAIN-2", "FAULT-DOMAIN-3"]

}

variable "network_type" {
  description = "Network type"
  default     = "PARAVIRTUALIZED"
}

variable "compute_availability_domain_map" {
  type        = map(any)
  description = "The name of the availability domain in which this node is placed"
}

/********** Instance Pool Variables **********/



/********** AutoScaling Config Variables **********/
variable "autoscaling_config_display_name" {
  description = "Configuration name for Autoscaling"

}

variable "is_autoscaling_enabled" {
  description = "Describes if autoscaling is enabled or not for this pool"
  default     = true
}

variable "is_scalein_enabled" {
  description = "Describes if scalein is enabled or not for this pool"
  default     = true
}

variable "schedule_scalein_time_window" {
  description = "Describes time window scaling in UTC and cron format"
}

variable "is_scaleout_enabled" {
  description = "Describes if scaleout is enabled or not for this pool"
  default     = true
}

variable "scaleout_instance_number" {
  description = "Describes the number for instances during scale out for this pool"
}

variable "schedule_scaleout_time_window" {
  description = "Describes time window scaling out UTC and cron format"
}

/********** AutoScaling Config Variables **********/

/********** Datasource and Subnet Lookup related variables **********/

variable "network_subnet_name" {
  description = "Defines the specific Subnet to be used for this resource"
}
/********** Datasource related variables **********/

/***********TEMP VARS FOR INTEGRATION WITH LBAAS - DO NOT PORT***************/
variable "lbaas_bes_name" {
  description = "LBaaS Back end o name"
  default = ""
}

variable "load_balancer_ocid" {
  description = "LBaaS OCID"
  default = ""
}

variable "lbaas_bes_checkport" {
  description = "Port where BES Healthcheck and where Load balancer listener is configured"
  default = ""
}

/***********TEMP VARS FOR INTEGRATION WITH LBAAS - DO NOT PORT***************/