# OCI Cloud Bricks: Linux Compute Instance Pool

[![License: UPL](https://img.shields.io/badge/license-UPL-green)](https://img.shields.io/badge/license-UPL-green) [![Quality gate](https://sonarcloud.io/api/project_badges/quality_gate?project=oracle-devrel_terraform-oci-cloudbricks-linux-compute-instance-pool)](https://sonarcloud.io/dashboard?id=oracle-devrel_terraform-oci-cloudbricks-linux-compute-instance-pool)

## Introduction
The following brick allows you to create a linux compute instance pool, attach a load balancer to it and create an autoscaling configuration of any kind.

## Reference Architecture
MISSING

### Prerequisites
- Pre-baked Artifact and Network Compartments
- Pre-baked VCN
- Custom Image for OS already made

---

# Sample tfvars file

If Flex Shape is in use, LBaaS is attached and schedule auto scaling is used

```shell
########## FLEX, LBAAS, SCHEDULE ##########
########## SAMPLE TFVAR FILE ##########
######################################## PROVIDER SPECIFIC VARIABLES ######################################
region       = "re-region-1"
tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaabcdefg"
user_ocid    = "ocid1.user.oc1..aaaaaaaahijklm"
fingerprint  = "fo:oo:ba:ar:ba:ar"
######################################## PROVIDER SPECIFIC VARIABLES ######################################
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
compute_availability_domain_map = { "ad1" : "aBCD:RE-REGION-1-AD-1" }

network_subnet_name                     = "My_Subnet"
assign_public_ip_flag                   = true
bkp_policy_boot_volume                  = "gold"
linux_compute_instance_compartment_name = "MY_ARTIFACT_COMPARTMENT"
linux_compute_network_compartment_name  = "MY_NETWORK_COMPARTMENT"
vcn_display_name                        = "MY_VCN"
is_load_balancer_required               = true
lbaas_bes_checkport                     = 80
lbaas_bes_name                          = "LBaaS_Backend_Set_Name"
load_balancer_ocid                      = "ocid1.loadbalancer.oc1.re-region-1.aaaaaaaaoprstuv"
pool_size                               = 2
is_flex_shape                           = true
instance_config_shape                   = "VM.Standard.E4.Flex"
instance_shape_config_ocpus             = 2
instance_shape_config_memory_in_gbs     = 32

instance_display_name_base          = "My_Instance"
compute_display_name_base           = "My_Instance_Pool"
base_compute_image_ocid             = "ocid1.image.oc1.re-region-1.aaaaaaaawxyz"
instance_configuration_display_name = "My_Config_Name"

autoscaling_config_display_name = "My_Autoscaling_Config_Name"
is_autoscaling_enabled          = true

autoscaling_is_schedule           = true
schedule_is_scalein_enabled       = true
schedule_is_scaleout_enabled      = true
schedule_scaleout_instance_number = 4
schedule_scaleout_time_window     = "0 0 4 24 * ? *"
schedule_scalein_time_window      = "0 0 4 5 * ? *"
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
########## SAMPLE TFVAR FILE ##########
########## FLEX, LBAAS, SCHEDULE ##########
```

If Flex Shape is in use, LBaaS isn't attached and schedule auto scaling is used

```shell
########## FLEX, NO LBAAS, SCHEDULE ##########
########## SAMPLE TFVAR FILE ##########
######################################## PROVIDER SPECIFIC VARIABLES ######################################
region       = "re-region-1"
tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaabcdefg"
user_ocid    = "ocid1.user.oc1..aaaaaaaahijklm"
fingerprint  = "fo:oo:ba:ar:ba:ar"
######################################## PROVIDER SPECIFIC VARIABLES ######################################
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
compute_availability_domain_map = { "ad1" : "aBCD:RE-REGION-1-AD-1" }

network_subnet_name                     = "My_Subnet"
assign_public_ip_flag                   = true
bkp_policy_boot_volume                  = "gold"
linux_compute_instance_compartment_name = "MY_ARTIFACT_COMPARTMENT"
linux_compute_network_compartment_name  = "MY_NETWORK_COMPARTMENT"
vcn_display_name                        = "MY_VCN"
pool_size                               = 2
is_flex_shape                           = true
instance_config_shape                   = "VM.Standard.E4.Flex"
instance_shape_config_ocpus             = 2
instance_shape_config_memory_in_gbs     = 32

instance_display_name_base          = "My_Instance"
compute_display_name_base           = "My_Instance_Pool"
base_compute_image_ocid             = "ocid1.image.oc1.re-region-1.aaaaaaaawxyz"
instance_configuration_display_name = "My_Config_Name"

autoscaling_config_display_name = "My_Autoscaling_Config_Name"
is_autoscaling_enabled          = true

autoscaling_is_schedule           = true
schedule_is_scalein_enabled       = true
schedule_is_scaleout_enabled      = true
schedule_scaleout_instance_number = 4
schedule_scaleout_time_window     = "0 0 4 24 * ? *"
schedule_scalein_time_window      = "0 0 4 5 * ? *"
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
########## SAMPLE TFVAR FILE ##########
########## FLEX, NO LBAAS, SCHEDULE ##########
```

If Flex Shape is in use, LBaaS is attached and CPU auto scaling is used

```shell
########## FLEX, LBAAS, CPU ##########
########## SAMPLE TFVAR FILE ##########
######################################## PROVIDER SPECIFIC VARIABLES ######################################
region       = "re-region-1"
tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaabcdefg"
user_ocid    = "ocid1.user.oc1..aaaaaaaahijklm"
fingerprint  = "fo:oo:ba:ar:ba:ar"
######################################## PROVIDER SPECIFIC VARIABLES ######################################
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
compute_availability_domain_map = { "ad1" : "aBCD:RE-REGION-1-AD-1" }

network_subnet_name                     = "My_Subnet"
assign_public_ip_flag                   = true
bkp_policy_boot_volume                  = "gold"
linux_compute_instance_compartment_name = "MY_ARTIFACT_COMPARTMENT"
linux_compute_network_compartment_name  = "MY_NETWORK_COMPARTMENT"
vcn_display_name                        = "MY_VCN"
is_load_balancer_required               = true
lbaas_bes_checkport                     = 80
lbaas_bes_name                          = "LBaaS_Backend_Set_Name"
load_balancer_ocid                      = "ocid1.loadbalancer.oc1.re-region-1.aaaaaaaaoprstuv"
pool_size                               = 2
is_flex_shape                           = true
instance_config_shape                   = "VM.Standard.E4.Flex"
instance_shape_config_ocpus             = 2
instance_shape_config_memory_in_gbs     = 32

instance_display_name_base          = "My_Instance"
compute_display_name_base           = "My_Instance_Pool"
base_compute_image_ocid             = "ocid1.image.oc1.re-region-1.aaaaaaaawxyz"
instance_configuration_display_name = "My_Config_Name"

autoscaling_config_display_name = "My_Autoscaling_Config_Name"
is_autoscaling_enabled          = true

autoscaling_is_cpu            = true
max_autoscale_instance_number = 4
min_autoscale_instance_number = 2
threshold_scale_out           = 80
threshold_scale_in            = 20
scaleout_step                 = 1
scalein_step                  = 1
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
########## SAMPLE TFVAR FILE ##########
########## FLEX, LBAAS, CPU ##########
```

If Flex Shape is in use, LBaaS isn't attached and CPU auto scaling is used

```shell
########## FLEX, NO LBAAS, CPU ##########
########## SAMPLE TFVAR FILE ##########
######################################## PROVIDER SPECIFIC VARIABLES ######################################
region       = "re-region-1"
tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaabcdefg"
user_ocid    = "ocid1.user.oc1..aaaaaaaahijklm"
fingerprint  = "fo:oo:ba:ar:ba:ar"
######################################## PROVIDER SPECIFIC VARIABLES ######################################
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
compute_availability_domain_map = { "ad1" : "aBCD:RE-REGION-1-AD-1" }

network_subnet_name                     = "My_Subnet"
assign_public_ip_flag                   = true
bkp_policy_boot_volume                  = "gold"
linux_compute_instance_compartment_name = "MY_ARTIFACT_COMPARTMENT"
linux_compute_network_compartment_name  = "MY_NETWORK_COMPARTMENT"
vcn_display_name                        = "MY_VCN"
pool_size                               = 2
is_flex_shape                           = true
instance_config_shape                   = "VM.Standard.E4.Flex"
instance_shape_config_ocpus             = 2
instance_shape_config_memory_in_gbs     = 32

instance_display_name_base          = "My_Instance"
compute_display_name_base           = "My_Instance_Pool"
base_compute_image_ocid             = "ocid1.image.oc1.re-region-1.aaaaaaaawxyz"
instance_configuration_display_name = "My_Config_Name"

autoscaling_config_display_name = "My_Autoscaling_Config_Name"
is_autoscaling_enabled          = true

autoscaling_is_cpu            = true
max_autoscale_instance_number = 4
min_autoscale_instance_number = 2
threshold_scale_out           = 80
threshold_scale_in            = 20
scaleout_step                 = 1
scalein_step                  = 1
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
########## SAMPLE TFVAR FILE ##########
########## FLEX, NO LBAAS, CPU ##########
```

If Flex Shape is in use, LBaaS is attached and memory auto scaling is used

```shell
########## FLEX, LBAAS, MEMORY ##########
########## SAMPLE TFVAR FILE ##########
######################################## PROVIDER SPECIFIC VARIABLES ######################################
region       = "re-region-1"
tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaabcdefg"
user_ocid    = "ocid1.user.oc1..aaaaaaaahijklm"
fingerprint  = "fo:oo:ba:ar:ba:ar"
######################################## PROVIDER SPECIFIC VARIABLES ######################################
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
compute_availability_domain_map = { "ad1" : "aBCD:RE-REGION-1-AD-1" }

network_subnet_name                     = "My_Subnet"
assign_public_ip_flag                   = true
bkp_policy_boot_volume                  = "gold"
linux_compute_instance_compartment_name = "MY_ARTIFACT_COMPARTMENT"
linux_compute_network_compartment_name  = "MY_NETWORK_COMPARTMENT"
vcn_display_name                        = "MY_VCN"
is_load_balancer_required               = true
lbaas_bes_checkport                     = 80
lbaas_bes_name                          = "LBaaS_Backend_Set_Name"
load_balancer_ocid                      = "ocid1.loadbalancer.oc1.re-region-1.aaaaaaaaoprstuv"
pool_size                               = 2
is_flex_shape                           = true
instance_config_shape                   = "VM.Standard.E4.Flex"
instance_shape_config_ocpus             = 2
instance_shape_config_memory_in_gbs     = 32

instance_display_name_base          = "My_Instance"
compute_display_name_base           = "My_Instance_Pool"
base_compute_image_ocid             = "ocid1.image.oc1.re-region-1.aaaaaaaawxyz"
instance_configuration_display_name = "My_Config_Name"

autoscaling_config_display_name = "My_Autoscaling_Config_Name"
is_autoscaling_enabled          = true

autoscaling_is_memory         = true
max_autoscale_instance_number = 4
min_autoscale_instance_number = 2
threshold_scale_out           = 80
threshold_scale_in            = 20
scaleout_step                 = 1
scalein_step                  = 1
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
########## SAMPLE TFVAR FILE ##########
########## FLEX, LBAAS, MEMORY ##########
```

If Flex Shape is in use, LBaaS isn't attached and memory auto scaling is used

```shell
########## FLEX, NO LBAAS, MEMORY ##########
########## SAMPLE TFVAR FILE ##########
######################################## PROVIDER SPECIFIC VARIABLES ######################################
region       = "re-region-1"
tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaabcdefg"
user_ocid    = "ocid1.user.oc1..aaaaaaaahijklm"
fingerprint  = "fo:oo:ba:ar:ba:ar"
######################################## PROVIDER SPECIFIC VARIABLES ######################################
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
compute_availability_domain_map = { "ad1" : "aBCD:RE-REGION-1-AD-1" }

network_subnet_name                     = "My_Subnet"
assign_public_ip_flag                   = true
bkp_policy_boot_volume                  = "gold"
linux_compute_instance_compartment_name = "MY_ARTIFACT_COMPARTMENT"
linux_compute_network_compartment_name  = "MY_NETWORK_COMPARTMENT"
vcn_display_name                        = "MY_VCN"
pool_size                               = 2
is_flex_shape                           = true
instance_config_shape                   = "VM.Standard.E4.Flex"
instance_shape_config_ocpus             = 2
instance_shape_config_memory_in_gbs     = 32

instance_display_name_base          = "My_Instance"
compute_display_name_base           = "My_Instance_Pool"
base_compute_image_ocid             = "ocid1.image.oc1.re-region-1.aaaaaaaawxyz"
instance_configuration_display_name = "My_Config_Name"

autoscaling_config_display_name = "My_Autoscaling_Config_Name"
is_autoscaling_enabled          = true

autoscaling_is_memory         = true
max_autoscale_instance_number = 4
min_autoscale_instance_number = 2
threshold_scale_out           = 80
threshold_scale_in            = 20
scaleout_step                 = 1
scalein_step                  = 1
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
########## SAMPLE TFVAR FILE ##########
########## FLEX, NO LBAAS, MEMORY ##########
```

###################################################################### CUTOFF ######################################################################

If Flex Shape is not in use, LBaaS is attached and schedule auto scaling is used

```shell
########## NO FLEX, LBAAS, SCHEDULE ##########
########## SAMPLE TFVAR FILE ##########
######################################## PROVIDER SPECIFIC VARIABLES ######################################
region       = "re-region-1"
tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaabcdefg"
user_ocid    = "ocid1.user.oc1..aaaaaaaahijklm"
fingerprint  = "fo:oo:ba:ar:ba:ar"
######################################## PROVIDER SPECIFIC VARIABLES ######################################
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
compute_availability_domain_map = { "ad1" : "aBCD:RE-REGION-1-AD-1" }

network_subnet_name                     = "My_Subnet"
assign_public_ip_flag                   = true
bkp_policy_boot_volume                  = "gold"
linux_compute_instance_compartment_name = "MY_ARTIFACT_COMPARTMENT"
linux_compute_network_compartment_name  = "MY_NETWORK_COMPARTMENT"
vcn_display_name                        = "MY_VCN"
is_load_balancer_required               = true
lbaas_bes_checkport                     = 80
lbaas_bes_name                          = "LBaaS_Backend_Set_Name"
load_balancer_ocid                      = "ocid1.loadbalancer.oc1.re-region-1.aaaaaaaaoprstuv"
pool_size                               = 2
instance_config_shape                   = "VM.Standard2.1"

instance_display_name_base          = "My_Instance"
compute_display_name_base           = "My_Instance_Pool"
base_compute_image_ocid             = "ocid1.image.oc1.re-region-1.aaaaaaaawxyz"
instance_configuration_display_name = "My_Config_Name"

autoscaling_config_display_name = "My_Autoscaling_Config_Name"
is_autoscaling_enabled          = true

autoscaling_is_schedule           = true
schedule_is_scalein_enabled       = true
schedule_is_scaleout_enabled      = true
schedule_scaleout_instance_number = 4
schedule_scaleout_time_window     = "0 0 4 24 * ? *"
schedule_scalein_time_window      = "0 0 4 5 * ? *"
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
########## SAMPLE TFVAR FILE ##########
########## NO FLEX, LBAAS, SCHEDULE ##########
```

If Flex Shape is not in use, LBaaS isn't attached and schedule auto scaling is used

```shell
########## NO FLEX, NO LBAAS, SCHEDULE ##########
########## SAMPLE TFVAR FILE ##########
######################################## PROVIDER SPECIFIC VARIABLES ######################################
region       = "re-region-1"
tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaabcdefg"
user_ocid    = "ocid1.user.oc1..aaaaaaaahijklm"
fingerprint  = "fo:oo:ba:ar:ba:ar"
######################################## PROVIDER SPECIFIC VARIABLES ######################################
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
compute_availability_domain_map = { "ad1" : "aBCD:RE-REGION-1-AD-1" }

network_subnet_name                     = "My_Subnet"
assign_public_ip_flag                   = true
bkp_policy_boot_volume                  = "gold"
linux_compute_instance_compartment_name = "MY_ARTIFACT_COMPARTMENT"
linux_compute_network_compartment_name  = "MY_NETWORK_COMPARTMENT"
vcn_display_name                        = "MY_VCN"
pool_size                               = 2
instance_config_shape                   = "VM.Standard2.1"

instance_display_name_base          = "My_Instance"
compute_display_name_base           = "My_Instance_Pool"
base_compute_image_ocid             = "ocid1.image.oc1.re-region-1.aaaaaaaawxyz"
instance_configuration_display_name = "My_Config_Name"

autoscaling_config_display_name = "My_Autoscaling_Config_Name"
is_autoscaling_enabled          = true

autoscaling_is_schedule           = true
schedule_is_scalein_enabled       = true
schedule_is_scaleout_enabled      = true
schedule_scaleout_instance_number = 4
schedule_scaleout_time_window     = "0 0 4 24 * ? *"
schedule_scalein_time_window      = "0 0 4 5 * ? *"
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
########## SAMPLE TFVAR FILE ##########
########## NO FLEX, NO LBAAS, SCHEDULE ##########
```

If Flex Shape is not in use, LBaaS is attached and CPU auto scaling is used

```shell
########## NO FLEX, LBAAS, CPU ##########
########## SAMPLE TFVAR FILE ##########
######################################## PROVIDER SPECIFIC VARIABLES ######################################
region       = "re-region-1"
tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaabcdefg"
user_ocid    = "ocid1.user.oc1..aaaaaaaahijklm"
fingerprint  = "fo:oo:ba:ar:ba:ar"
######################################## PROVIDER SPECIFIC VARIABLES ######################################
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
compute_availability_domain_map = { "ad1" : "aBCD:RE-REGION-1-AD-1" }

network_subnet_name                     = "My_Subnet"
assign_public_ip_flag                   = true
bkp_policy_boot_volume                  = "gold"
linux_compute_instance_compartment_name = "MY_ARTIFACT_COMPARTMENT"
linux_compute_network_compartment_name  = "MY_NETWORK_COMPARTMENT"
vcn_display_name                        = "MY_VCN"
is_load_balancer_required               = true
lbaas_bes_checkport                     = 80
lbaas_bes_name                          = "LBaaS_Backend_Set_Name"
load_balancer_ocid                      = "ocid1.loadbalancer.oc1.re-region-1.aaaaaaaaoprstuv"
pool_size                               = 2
instance_config_shape                   = "VM.Standard2.1"

instance_display_name_base          = "My_Instance"
compute_display_name_base           = "My_Instance_Pool"
base_compute_image_ocid             = "ocid1.image.oc1.re-region-1.aaaaaaaawxyz"
instance_configuration_display_name = "My_Config_Name"

autoscaling_config_display_name = "My_Autoscaling_Config_Name"
is_autoscaling_enabled          = true

autoscaling_is_cpu            = true
max_autoscale_instance_number = 4
min_autoscale_instance_number = 2
threshold_scale_out           = 80
threshold_scale_in            = 20
scaleout_step                 = 1
scalein_step                  = 1
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
########## SAMPLE TFVAR FILE ##########
########## NO FLEX, LBAAS, CPU ##########
```

If Flex Shape is not in use, LBaaS isn't attached and CPU auto scaling is used

```shell
########## NO FLEX, NO LBAAS, CPU ##########
########## SAMPLE TFVAR FILE ##########
######################################## PROVIDER SPECIFIC VARIABLES ######################################
region       = "re-region-1"
tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaabcdefg"
user_ocid    = "ocid1.user.oc1..aaaaaaaahijklm"
fingerprint  = "fo:oo:ba:ar:ba:ar"
######################################## PROVIDER SPECIFIC VARIABLES ######################################
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
compute_availability_domain_map = { "ad1" : "aBCD:RE-REGION-1-AD-1" }

network_subnet_name                     = "My_Subnet"
assign_public_ip_flag                   = true
bkp_policy_boot_volume                  = "gold"
linux_compute_instance_compartment_name = "MY_ARTIFACT_COMPARTMENT"
linux_compute_network_compartment_name  = "MY_NETWORK_COMPARTMENT"
vcn_display_name                        = "MY_VCN"
pool_size                               = 2
instance_config_shape                   = "VM.Standard2.1"

instance_display_name_base          = "My_Instance"
compute_display_name_base           = "My_Instance_Pool"
base_compute_image_ocid             = "ocid1.image.oc1.re-region-1.aaaaaaaawxyz"
instance_configuration_display_name = "My_Config_Name"

autoscaling_config_display_name = "My_Autoscaling_Config_Name"
is_autoscaling_enabled          = true

autoscaling_is_cpu            = true
max_autoscale_instance_number = 4
min_autoscale_instance_number = 2
threshold_scale_out           = 80
threshold_scale_in            = 20
scaleout_step                 = 1
scalein_step                  = 1
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
########## SAMPLE TFVAR FILE ##########
########## NO FLEX, NO LBAAS, CPU ##########
```

If Flex Shape is not in use, LBaaS is attached and memory auto scaling is used

```shell
########## NO FLEX, LBAAS, MEMORY ##########
########## SAMPLE TFVAR FILE ##########
######################################## PROVIDER SPECIFIC VARIABLES ######################################
region       = "re-region-1"
tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaabcdefg"
user_ocid    = "ocid1.user.oc1..aaaaaaaahijklm"
fingerprint  = "fo:oo:ba:ar:ba:ar"
######################################## PROVIDER SPECIFIC VARIABLES ######################################
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
compute_availability_domain_map = { "ad1" : "aBCD:RE-REGION-1-AD-1" }

network_subnet_name                     = "My_Subnet"
assign_public_ip_flag                   = true
bkp_policy_boot_volume                  = "gold"
linux_compute_instance_compartment_name = "MY_ARTIFACT_COMPARTMENT"
linux_compute_network_compartment_name  = "MY_NETWORK_COMPARTMENT"
vcn_display_name                        = "MY_VCN"
is_load_balancer_required               = true
lbaas_bes_checkport                     = 80
lbaas_bes_name                          = "LBaaS_Backend_Set_Name"
load_balancer_ocid                      = "ocid1.loadbalancer.oc1.re-region-1.aaaaaaaaoprstuv"
pool_size                               = 2
instance_config_shape                   = "VM.Standard2.1"

instance_display_name_base          = "My_Instance"
compute_display_name_base           = "My_Instance_Pool"
base_compute_image_ocid             = "ocid1.image.oc1.re-region-1.aaaaaaaawxyz"
instance_configuration_display_name = "My_Config_Name"

autoscaling_config_display_name = "My_Autoscaling_Config_Name"
is_autoscaling_enabled          = true

autoscaling_is_memory         = true
max_autoscale_instance_number = 4
min_autoscale_instance_number = 2
threshold_scale_out           = 80
threshold_scale_in            = 20
scaleout_step                 = 1
scalein_step                  = 1
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
########## SAMPLE TFVAR FILE ##########
########## NO FLEX, LBAAS, MEMORY ##########
```

If Flex Shape is not in use, LBaaS isn't attached and memory auto scaling is used

```shell
########## NO FLEX, NO LBAAS, MEMORY ##########
########## SAMPLE TFVAR FILE ##########
######################################## PROVIDER SPECIFIC VARIABLES ######################################
region       = "re-region-1"
tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaabcdefg"
user_ocid    = "ocid1.user.oc1..aaaaaaaahijklm"
fingerprint  = "fo:oo:ba:ar:ba:ar"
######################################## PROVIDER SPECIFIC VARIABLES ######################################
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
compute_availability_domain_map = { "ad1" : "aBCD:RE-REGION-1-AD-1" }

network_subnet_name                     = "My_Subnet"
assign_public_ip_flag                   = true
bkp_policy_boot_volume                  = "gold"
linux_compute_instance_compartment_name = "MY_ARTIFACT_COMPARTMENT"
linux_compute_network_compartment_name  = "MY_NETWORK_COMPARTMENT"
vcn_display_name                        = "MY_VCN"
pool_size                               = 2
instance_config_shape                   = "VM.Standard2.1"

instance_display_name_base          = "My_Instance"
compute_display_name_base           = "My_Instance_Pool"
base_compute_image_ocid             = "ocid1.image.oc1.re-region-1.aaaaaaaawxyz"
instance_configuration_display_name = "My_Config_Name"

autoscaling_config_display_name = "My_Autoscaling_Config_Name"
is_autoscaling_enabled          = true

autoscaling_is_memory         = true
max_autoscale_instance_number = 4
min_autoscale_instance_number = 2
threshold_scale_out           = 80
threshold_scale_in            = 20
scaleout_step                 = 1
scalein_step                  = 1
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
########## SAMPLE TFVAR FILE ##########
########## NO FLEX, NO LBAAS, MEMORY ##########
```

### Variable specific considerations
- Variable `lbaas_bes_checkport` does not currently work with HTTPS/443.
- Variable `pool_size` is only the initial size of the instance pool. Auto scaling can be defined to go beyond this number.
- Variable `is_flex_shape` should be defined as true when required. The variables `instance_shape_config_ocpus` and `instance_shape_config_memory_in_gbs` should then also be defined. Do not use any of these variables at all when using a standard shape as they are not needed.
- Variable `base_compute_image_ocid` should be the OCID of a custom image of the desired operating system generated from a dummy instance.
- Variable `is_autoscaling_enabled` determines whether the autoscaling configuartion is enabled or not, but it will still be provisioned as long as one of the below three auto scaling types is set to true.
- Only one of the variables `autoscaling_is_schedule`, `autoscaling_is_cpu` or `autoscaling_is_memory` should be set to true. This determines which type of autoscaling is enabled, whether the pool is scaled on a schedule, by CPU utilization or memory utilization respectively. 
  - `autoscaling_is_schedule` makes use of variables:
    - `schedule_is_scalein_enabled`: Determines whether the pool should scale in on given time window `schedule_scalein_time_window`
    - `schedule_is_scaleout_enabled`: Determines whether the pool should scale out on given time window `schedule_scaleout_time_window`
    - `schedule_scaleout_instance_number`: Number of instance to scale to when scaling out
    - `schedule_scaleout_time_window`: Determines when to scale out
    - `schedule_scalein_time_window`: Determines when to scale in
  - `autoscaling_is_cpu` and `autoscaling_is_memory` make use of variables:
    - `max_autoscale_instance_number`: Maximum number of instances to scale to
    - `min_autoscale_instance_number`: Minimum number of instances to scale to
    - `threshold_scale_out`: Upper performance threshold to trigger scaling out
    - `threshold_scale_in`: Lower performance threshold to trigger scaling in
    - `scaleout_step`: Number of instance to scale out by when `threshold_scale_out` is met
    - `scalein_step`: Number of instance to scale in by when `threshold_scale_in` is met

### Sample provider

The following is the base provider definition to be used with this module

```shell
terraform {
  required_version = ">= 0.13.5"
}
provider "oci" {
  region       = var.region
  tenancy_ocid = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  disable_auto_retries = "true"
}

provider "oci" {
  alias        = "home"
  region       = data.oci_identity_region_subscriptions.home_region_subscriptions.region_subscriptions[0].region_name
  tenancy_ocid = var.tenancy_ocid  
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  disable_auto_retries = "true"
}
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 4.40.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_autoscaling_auto_scaling_configuration.CPUAutoScalingConfig](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/autoscaling_auto_scaling_configuration) | resource |
| [oci_autoscaling_auto_scaling_configuration.MemoryAutoScalingConfig](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/autoscaling_auto_scaling_configuration) | resource |
| [oci_autoscaling_auto_scaling_configuration.ScheduleAutoScalingConfig](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/autoscaling_auto_scaling_configuration) | resource |
| [oci_core_instance_configuration.InstanceConfiguration](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_instance_configuration) | resource |
| [oci_core_instance_pool.InstancePool](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_instance_pool) | resource |
| [oci_core_instance_configurations.INSTANCECONFIGURATIONS](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/core_instance_configurations) | data source |
| [oci_core_instance_pool_instances.POOLINSTANCES](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/core_instance_pool_instances) | data source |
| [oci_core_subnets.SUBNET](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/core_subnets) | data source |
| [oci_core_vcns.VCN](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/core_vcns) | data source |
| [oci_core_volume_backup_policies.BACKUPPOLICYBOOTVOL](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/core_volume_backup_policies) | data source |
| [oci_identity_compartments.COMPARTMENTS](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_compartments) | data source |
| [oci_identity_compartments.NWCOMPARTMENTS](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_compartments) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assign_public_ip_flag"></a> [assign\_public\_ip\_flag](#input\_assign\_public\_ip\_flag) | Defines either machine will have or not a Public IP assigned. All Pvt networks this variable must be false | `bool` | `false` | no |
| <a name="input_autoscaling_config_display_name"></a> [autoscaling\_config\_display\_name](#input\_autoscaling\_config\_display\_name) | Configuration name for Autoscaling | `any` | n/a | yes |
| <a name="input_autoscaling_is_cpu"></a> [autoscaling\_is\_cpu](#input\_autoscaling\_is\_cpu) | Boolean that desribe if autoscaling is cpu based or not | `bool` | `false` | no |
| <a name="input_autoscaling_is_memory"></a> [autoscaling\_is\_memory](#input\_autoscaling\_is\_memory) | Boolean that desribe if autoscaling is memory based or not | `bool` | `false` | no |
| <a name="input_autoscaling_is_schedule"></a> [autoscaling\_is\_schedule](#input\_autoscaling\_is\_schedule) | Boolean that desribe if autoscaling is schedule based or not | `bool` | `false` | no |
| <a name="input_base_compute_image_ocid"></a> [base\_compute\_image\_ocid](#input\_base\_compute\_image\_ocid) | Defines the OCID for the OS image to be used on artifact creation. Extract OCID from: https://docs.cloud.oracle.com/iaas/images/ or designated custom image OCID created by packer | `any` | n/a | yes |
| <a name="input_bkp_policy_boot_volume"></a> [bkp\_policy\_boot\_volume](#input\_bkp\_policy\_boot\_volume) | Describes the backup policy attached to the boot volume | `string` | `"gold"` | no |
| <a name="input_compute_availability_domain_map"></a> [compute\_availability\_domain\_map](#input\_compute\_availability\_domain\_map) | The name of the availability domain in which this node is placed | `map(any)` | n/a | yes |
| <a name="input_compute_display_name_base"></a> [compute\_display\_name\_base](#input\_compute\_display\_name\_base) | Defines the compute and hostname Label for created compute | `any` | n/a | yes |
| <a name="input_fault_domain_list"></a> [fault\_domain\_list](#input\_fault\_domain\_list) | Fault Domain List | `list(any)` | <pre>[<br>  "FAULT-DOMAIN-1",<br>  "FAULT-DOMAIN-2",<br>  "FAULT-DOMAIN-3"<br>]</pre> | no |
| <a name="input_fingerprint"></a> [fingerprint](#input\_fingerprint) | API Key Fingerprint for user\_ocid derived from public API Key imported in OCI User config | `any` | n/a | yes |
| <a name="input_instance_config_shape"></a> [instance\_config\_shape](#input\_instance\_config\_shape) | Defines the shape to be used on compute creation | `any` | n/a | yes |
| <a name="input_instance_configuration_display_name"></a> [instance\_configuration\_display\_name](#input\_instance\_configuration\_display\_name) | Display name for instance configuration | `any` | n/a | yes |
| <a name="input_instance_display_name_base"></a> [instance\_display\_name\_base](#input\_instance\_display\_name\_base) | Instance base display name | `any` | n/a | yes |
| <a name="input_instance_shape_config_memory_in_gbs"></a> [instance\_shape\_config\_memory\_in\_gbs](#input\_instance\_shape\_config\_memory\_in\_gbs) | Memory assigned to computes in pool | `string` | `""` | no |
| <a name="input_instance_shape_config_ocpus"></a> [instance\_shape\_config\_ocpus](#input\_instance\_shape\_config\_ocpus) | OCPU assigned computes in pool | `string` | `""` | no |
| <a name="input_is_autoscaling_enabled"></a> [is\_autoscaling\_enabled](#input\_is\_autoscaling\_enabled) | Describes if autoscaling is enabled or not for this pool | `bool` | `false` | no |
| <a name="input_is_compute_in_hub_dmz01"></a> [is\_compute\_in\_hub\_dmz01](#input\_is\_compute\_in\_hub\_dmz01) | Defines if the compute is going to be created in Hub DMZ01 Subnet | `bool` | `false` | no |
| <a name="input_is_compute_in_hub_svc01"></a> [is\_compute\_in\_hub\_svc01](#input\_is\_compute\_in\_hub\_svc01) | Defines if the compute is going to be created in the Hub SharedSvc01 Subnet | `bool` | `false` | no |
| <a name="input_is_flex_shape"></a> [is\_flex\_shape](#input\_is\_flex\_shape) | Boolean that describes if the shape is flex or not | `bool` | `false` | no |
| <a name="input_is_load_balancer_required"></a> [is\_load\_balancer\_required](#input\_is\_load\_balancer\_required) | Boolean that determines if load balancer attachment is required or not | `bool` | `false` | no |
| <a name="input_label_zs"></a> [label\_zs](#input\_label\_zs) | n/a | `list(any)` | <pre>[<br>  "0",<br>  ""<br>]</pre> | no |
| <a name="input_launch_mode"></a> [launch\_mode](#input\_launch\_mode) | Launch mode in which the image will be executed | `string` | `"NATIVE"` | no |
| <a name="input_lbaas_bes_checkport"></a> [lbaas\_bes\_checkport](#input\_lbaas\_bes\_checkport) | Port where BES Healthcheck and where Load balancer listener is configured | `string` | `""` | no |
| <a name="input_lbaas_bes_name"></a> [lbaas\_bes\_name](#input\_lbaas\_bes\_name) | LBaaS Back end set name | `string` | `""` | no |
| <a name="input_linux_compute_instance_compartment_id"></a> [linux\_compute\_instance\_compartment\_id](#input\_linux\_compute\_instance\_compartment\_id) | Defines the compartment OCID where the infrastructure will be created | `string` | `""` | no |
| <a name="input_linux_compute_instance_compartment_name"></a> [linux\_compute\_instance\_compartment\_name](#input\_linux\_compute\_instance\_compartment\_name) | Defines the compartment name where the infrastructure will be created | `string` | `""` | no |
| <a name="input_linux_compute_network_compartment_name"></a> [linux\_compute\_network\_compartment\_name](#input\_linux\_compute\_network\_compartment\_name) | Defines the compartment where the Network is currently located | `any` | n/a | yes |
| <a name="input_load_balancer_ocid"></a> [load\_balancer\_ocid](#input\_load\_balancer\_ocid) | LBaaS OCID | `string` | `""` | no |
| <a name="input_maintainance_action"></a> [maintainance\_action](#input\_maintainance\_action) | Instance maintainence action | `string` | `"LIVE_MIGRATE"` | no |
| <a name="input_max_autoscale_instance_number"></a> [max\_autoscale\_instance\_number](#input\_max\_autoscale\_instance\_number) | Maximum number of instance that can be scaled to when using threshold scaling configurations | `string` | `""` | no |
| <a name="input_min_autoscale_instance_number"></a> [min\_autoscale\_instance\_number](#input\_min\_autoscale\_instance\_number) | Minimum number of instance that can be scaled to when using threshold scaling configurations | `string` | `""` | no |
| <a name="input_network_subnet_name"></a> [network\_subnet\_name](#input\_network\_subnet\_name) | Defines the specific Subnet to be used for this resource | `any` | n/a | yes |
| <a name="input_network_type"></a> [network\_type](#input\_network\_type) | Network type | `string` | `"PARAVIRTUALIZED"` | no |
| <a name="input_pool_size"></a> [pool\_size](#input\_pool\_size) | Amount of instances to create | `any` | n/a | yes |
| <a name="input_primary_vnic_display_name"></a> [primary\_vnic\_display\_name](#input\_primary\_vnic\_display\_name) | Defines the Primary VNIC Display Name | `string` | `"primaryvnic"` | no |
| <a name="input_private_ip"></a> [private\_ip](#input\_private\_ip) | Describes the private IP required for machine | `any` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | Target region where artifacts are going to be created | `any` | n/a | yes |
| <a name="input_scalein_step"></a> [scalein\_step](#input\_scalein\_step) | Number of instances to scale by in threshold confiogurations | `string` | `""` | no |
| <a name="input_scaleout_step"></a> [scaleout\_step](#input\_scaleout\_step) | Number of instances to scale by in threshold confiogurations | `string` | `""` | no |
| <a name="input_schedule_is_scalein_enabled"></a> [schedule\_is\_scalein\_enabled](#input\_schedule\_is\_scalein\_enabled) | Describes if scalein is enabled or not for this pool | `bool` | `false` | no |
| <a name="input_schedule_is_scaleout_enabled"></a> [schedule\_is\_scaleout\_enabled](#input\_schedule\_is\_scaleout\_enabled) | Describes if scaleout is enabled or not for this pool | `bool` | `false` | no |
| <a name="input_schedule_scalein_time_window"></a> [schedule\_scalein\_time\_window](#input\_schedule\_scalein\_time\_window) | Describes time window scaling in UTC and cron format | `string` | `""` | no |
| <a name="input_schedule_scaleout_instance_number"></a> [schedule\_scaleout\_instance\_number](#input\_schedule\_scaleout\_instance\_number) | Describes the number for instances during scale out for this pool | `string` | `""` | no |
| <a name="input_schedule_scaleout_time_window"></a> [schedule\_scaleout\_time\_window](#input\_schedule\_scaleout\_time\_window) | Describes time window scaling out UTC and cron format | `string` | `""` | no |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | OCID of tenancy | `any` | n/a | yes |
| <a name="input_threshold_scale_in"></a> [threshold\_scale\_in](#input\_threshold\_scale\_in) | Threshold of CPU or memory utilization to cause a scale in | `string` | `""` | no |
| <a name="input_threshold_scale_out"></a> [threshold\_scale\_out](#input\_threshold\_scale\_out) | Threshold of CPU or memory utilization to cause a scale out | `string` | `""` | no |
| <a name="input_user_ocid"></a> [user\_ocid](#input\_user\_ocid) | User OCID in tenancy | `any` | n/a | yes |
| <a name="input_vcn_display_name"></a> [vcn\_display\_name](#input\_vcn\_display\_name) | Name of the VCN where artifact is associated with | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_configuration"></a> [instance\_configuration](#output\_instance\_configuration) | Instance Configuration |
| <a name="output_instance_pool"></a> [instance\_pool](#output\_instance\_pool) | Instance Pool |
| <a name="output_instance_pool_computes"></a> [instance\_pool\_computes](#output\_instance\_pool\_computes) | Computes created inside instance pool |
| <a name="output_instance_pool_computes_instances"></a> [instance\_pool\_computes\_instances](#output\_instance\_pool\_computes\_instances) | n/a |

## Contributing
This project is open source.  Please submit your contributions by forking this repository and submitting a pull request!  Oracle appreciates any contributions that are made by the open source community.

## License
Copyright (c) 2021 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](LICENSE) for more details.
