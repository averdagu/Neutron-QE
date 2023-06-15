---
config:
    entry_point: ./ovn_migration/infrared/tripleo-ovn-migration/main.yml
    plugin_type: install
subparsers:
    tripleo-ovn-migration:
        description: Migrate an existing TripleO overcloud from Neutron ML2OVS plugin to OVN
        include_groups: ["Ansible options", "Inventory", "Common options", "Answers file"]
        groups:
            - title: Deployment Description
              options:
                  dvr:
                      type: Bool
                      help: If the deployment is to be dvr or not
                      default: False

                  sriov:
                      type: Bool
                      help: If the environment uses SR-IOV
                      default: False

                  after_ffu:
                      type: Bool
                      help: If the environment is after Fast Forward Upgrade
                      default: False

                  external_network:
                      type: Value
                      help: External network name to use
                      default: public

                  stack_name:
                      type: Value
                      help: Name of the stack to update
                      default: overcloud

                  overcloud_ssh_user:
                      type: Value
                      help: SSH user for connecting to overcloud nodes
                      default: heat-admin

                  jumbo_mtu:
                      type: Bool
                      help: Whether target environment should support jumbo MTU.
                      default: False

                  networker:
                      type: Bool
                      help: Whether environment has standalone networkers.
                      default: False

                  controller_nfs:
                      type: Bool
                      help: Whether controller nfs nodes should work as OVN gateways
                      default: True

                  vlan_transparency:
                      type: Bool
                      help: Whether target environment should have VLAN transtarency enabled.
                      default: True

                  igmp_snooping:
                      type: Bool
                      help: Whether target environment should have IGMP snooping enabled.
                      default: True

                  neutron_dns_domain:
                      type: Value
                      help: A string to use as a Neutron DNS domain.
                      default: openstackgate.local

                  geneve:
                      type: Bool
                      help: Whether to change tunnel to geneve.
                      default: True

            - title: Workload
              options:
                  create_resources:
                      type: Bool
                      help: Create resources to measure downtime
                      default: True

                  resources_type:
                      type: Value
                      help: |
                          Type of resources we want to create
                          normal: creates amount of VMs matching number of compute nodes
                          normal_ext: same as normal but creates VMs on external network
                          normal_ext_int: combination of normal and normal_ext
                          dvr: same as normal but creates DVR router instead of HA
                          sriov_int_no_pf: as normal but creates also VMs with SR-IOV VF(direct) ports
                          sriov_int: as sriov_int_no_pf but creates also VMs with SR-IOV PF(direct-physical) ports
                          sriov_int_vf: creates VMs only with direct(VF) ports
                          sriov_ext_no_pf: as sriov_int_no_pf but creates VMs connected to the external network
                          sriov_ext_no_pf_with_trunk: creates VMs with direct(VF) ports and VMs with trunk ports, all on external network
                          sriov_ext: as sriov_ext_no_pf but creates also VMs with SR-IOV PF(direct-physical) ports
                          sriov_ext_with_trunk: like sriov_ext, but additionally creates VMs with trunk ports, all on external network
                          sriov_ext_vf: creates VMs only with direct(VF) ports on external network
                          trunk: create VMs with trunk ports
                          trunk_ext: use VMs with trunk ports, launch VMs on external(aka provider) network
                          trunk_ext_with_normal_int: use VMs with trunk ports, launch VMs on external(aka provider) network. Additionally run VMs according to normal type
                          granular_poc: create workload suitable for testing granular approach of migration/revert, where there are 2 groups of VMs, requires minimum 4 compute nodes
                      choices:
                        - normal
                        - normal_ext
                        - normal_ext_int
                        - dvr
                        - sriov_int_vf
                        - sriov_int_no_pf
                        - sriov_int
                        - sriov_ext_vf
                        - sriov_ext_no_pf
                        - sriov_ext_no_pf_with_trunk
                        - sriov_ext
                        - sriov_ext_with_trunk
                        - trunk
                        - trunk_ext
                        - trunk_ext_with_normal_int
                        - granular_poc
                      default: normal_ext_int

                  image_name:
                      type: Value
                      help: Image name to use
                      default: cirros

                  flavor_name:
                      type: Value
                      help: Flavor name to use for creating VMs.
                      default: cirros

                  export_image:
                      type: Bool
                      help: Whether to export image and flavor to OVN migration script. If it is set to False, the OVN migration script will use own values.
                      default: False

                  server_user_name:
                      type: Value
                      help: User name to use for login to the resources VMs
                      default: cirros

                  create_loadbalancer:
                      type: Bool
                      help: Whether to create a Octavia load balancer and add workload VMs as members.
                      default: False

                  create_validation_workload:
                      type: Bool
                      help: Whether to create pre/post-migration validation workload (in addition to the pinger workload defined by create_resources parameter).
                      default: False

                  allowed_packet_loss:
                      type: Value
                      help: How many pinger requests to workload are allowed to fail.
                      default: 15

                  shutdown_workload:
                      type: Bool
                      help: Whether to keep workload down during the OVN migration
                      default: False

                  reduce_mtu:
                      type: Bool
                      help: Whether to reduce MTU since GENEVE has bigger header than VxLAN. Note, in some cases it may be useful to set it to False and keep current MTU.
                      default: True

                  ensure_mtu_is_updated:
                      type: Bool
                      help: Whether to go over all relevant workload VMs before migration and make sure MTU is set properly, reboot the VM if needed.
                      default: False

                  delete_workload:
                      type: Bool
                      help: Whether to delete workload after migration completed.
                      default: False

            - title: Validations
              options:
                  validate_ipv6:
                      type: Bool
                      help: Whether to validate ipv6.
                      default: True

                  validate_agents:
                      type: Bool
                      help: Whether to validate agents health before and after migration to OVN and check that OVS-related agents are removed.
                      default: True

                  validate_nodes:
                      type: Bool
                      help: Whether to check if nodes have OVS-specific leftovers (namespaces and interfaces) after migration to OVN.
                      default: True

                  validate_pcs_status:
                      type: Bool
                      help: Whether to check pcs status on controller nodes.
                      default: True

                  validate_vm_cold_migration:
                      type: Bool
                      help: Whether to cold migrate workload VMs after migration to OVN and check connectivity.
                      default: False

                  validate_vm_live_migration:
                      type: Bool
                      help: Whether to live migrate workload VMs after migration to OVN and check connectivity.
                      default: True

                  validate_vm_migration:
                      type: Bool
                      help: Whether to migrate workload VMs (both, i.e. cold and live scenario) after migration to OVN and check connectivity.
                      default: True

                  validate_vm_reboot:
                      type: Bool
                      help: Whether to reboot workload VMs after migration to OVN and check connectivity.
                      default: True

                  ping_during_vm_migration:
                      type: Bool
                      help: Whether to ping VM during the VM live migration
                      default: True

                  fetch_junit_xml:
                      type: Bool
                      help: Whether to fetch junit xml with validation results.
                      default: True

                  skip_validations:
                      type: Bool
                      help: Whether to skip post-migration validations. This is useful if we plan to test migration revert.
                      default: False

                  run_collectd:
                      type: Bool
                      help: Whether to install and run collectd
                      default: False

            - title: Workarounds
              options:
                  migrate:
                      type: Bool
                      help: Whether to migrate to OVN. The option allows to run some configuration scenarios without performing the migration itself.
                      default: True

                  dump_objects:
                      type: Bool
                      help: Whether to dump objects before and after migration
                      default: False

                  batches_config:
                      type: Value
                      help: URL with batches config. In case there is a need to override default one.
                      default: ''

                  batched_scenario_tasks:
                      type: Value
                      help: URL with a file that contains tasks to execute using batched scenario.
                      default: ''

                  fix_workload_mtu:
                      type: Bool
                      help: Whether to go over all workload VMs and reduce MTU before starting the migration.
                      default: False

                  fix_firewall_driver:
                      type: Bool
                      help: Whether to go over all compute nodes and set supported firewall driver (openvswitch) prior OVN migration
                      default: False

                  patch_flavor_size:
                      type: Bool
                      help: Temporary workaround. Whether to change flavor disk size to 10 in neutron OVN migration playbooks.
                      default: False

                  print_vm_console_on_fail:
                      type: Bool
                      help: Temporary workaround. Whether to inject to ovn migration playbooks an option to print workload VM console in case of failure
                      default: True

                  disable_pre_checks:
                      type: Bool
                      help: Temporary workaround. Whether to disable pre-migration checks.
                      default: False

                  fix_poolmetadatasize:
                      type: Bool
                      help: Temporary workaround. Whether to inject a code that fixes node recovery issue caused by BZ2149586.
                      default: True

                  fix_external_dhcp_ovs:
                      type: Bool
                      help: Whether to stop dhcp on hypervisor and configure static ip on undercloud. Can help to fix some tempest issues with VMs on external network with OVS
                      default: True

                  fix_notify_nova:
                      type: Bool
                      help: Temporary workaround. Whether to apply fix from https://code.engineering.redhat.com/gerrit/c/neutron/+/443850
                      default: False

            - title: Revert migration
              options:
                  revert_to_ovs:
                      type: Bool
                      help: Whether to revert to OVS.
                      default: False

                  create_backup:
                      type: Bool
                      help: Whether to create backup. In case user chooses revert_to_ovs he should enable this as well unless he has a valid backup already and wants to save some time.
                      default: False

                  backup_migration_ip:
                      type: Value
                      help: A host where to save backup.
                      default: 192.168.24.1

                  backup_migration_ctl_plane_cidrs:
                      type: Value
                      help: Control plane CIDRs for backup. Can contain more than one value, e.g. 192.168.25.0/25,10.0.1.1/30. See details in BZ#2158437
                      default: ''

                  fix_subnet_for_backup:
                      type: Bool
                      help: Temporary workaround. Inject parameter to override default subnets, see https://bugzilla.redhat.com/show_bug.cgi?id=2158437
                      default: False

                  fix_controller_group_name_for_sriov:
                      type: Bool
                      help: Temporary workaround. Inject parameter to override controller group name, see https://bugzilla.redhat.com/show_bug.cgi?id=2158396
                      default: False

                  fix_inventory_for_backup:
                      type: Bool
                      help: Temporary workaround. Inject a variable with inventory file, fix for https://bugzilla.redhat.com/show_bug.cgi?id=2208238
                      default: False
