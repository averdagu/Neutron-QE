---
config:
    entry_point: ./ovn_migration/infrared/tripleo-ovn-migration/main.yml
    plugin_type: install
subparsers:
    tripleo-ovn-migration:
        description: Migrate an existing TripleO overcloud from Neutron ML2OVS plugin to OVN
        include_groups: ["Ansible options", "Inventory", "Common options", "Answers file"]
        groups:
            - title: Containers
              options:
                  registry-namespace:
                      type: Value
                      help: The alternative docker registry namespace to use for deployment.

                  registry-prefix:
                      type: Value
                      help: The images prefix

                  registry-tag:
                      type: Value
                      help: The images tag

                  registry-mirror:
                      type: Value
                      help: The alternative docker registry to use for deployment.

            - title: Deployment Description
              options:
                  version:
                      type: Value
                      help: |
                          The product version
                          Numbers are for OSP releases
                          Names are for RDO releases
                          If not given, same version of the undercloud will be used
                      choices:
                        - "16.1"
                        - "16.2"
                  install_from_package:
                      type: Bool
                      help: Install python-networking-ovn-migration-tool rpm
                      default: True

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
                      choices:
                        - normal
                        - normal_ext
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
                      default: trunk_ext

                  image_name:
                      type: Value
                      help: Image name to use
                      default: tempest_image

                  flavor_name:
                      type: Value
                      help: Flavor name to use for creating VMs.
                      default: guest_image

                  export_image:
                      type: Bool
                      help: Whether to export image and flavor to OVN migration script. If it is set to False, the OVN migration script will use own values.
                      default: False

                  server_user_name:
                      type: Value
                      help: User name to use for login to the resources VMs
                      default: cloud-user

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
                      default: 10

                  shutdown_workload:
                      type: Bool
                      help: Whether to keep workload down during the OVN migration
                      default: False

                  reduce_mtu:
                      type: Bool
                      help: Whether to reduce MTU since GENEVE has bigger header than VxLAN. Note, in some cases it may be useful to set it to False and keep current MTU.
                      default: True

                  validate_agents:
                      type: Bool
                      help: Whether to validate agents health before and after migration to OVN and check that OVS-related agents are removed.
                      default: True

                  validate_nodes:
                      type: Bool
                      help: Whether to check if nodes have OVS-specific leftovers (namespaces and interfaces) after migration to OVN.
                      default: False

                  validate_vm_live_migration:
                      type: Bool
                      help: Whether to live migrate workload VMs after migration to OVN and check connectivity.
                      default: False

                  validate_vm_reboot:
                      type: Bool
                      help: Whether to reboot workload VMs after migration to OVN and check connectivity.
                      default: False

            - title: Workarounds
              options:
                  migrate:
                      type: Bool
                      help: Whether to migrate to OVN. The option allows to run some configuration scenarios without performing the migration itself.
                      default: True

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

                  fix_trunks_cleanup:
                      type: Bool
                      help: Temporary workaround. Whether to ignore errors during trunks cleanup in case there are no trunks.
                      default: True

                  print_vm_console_on_fail:
                      type: Bool
                      help: Temporary workaround. Whether to inject to ovn migration playbooks an option to print workload VM console in case of failure
                      default: True

                  fix_ansible_inventory:
                      type: bool
                      help: Temporary workaround. Whether to apply a fix from https://review.opendev.org/c/openstack/neutron/+/834925/
                      default: False

                  fix_systemctl_daemon:
                      type: Bool
                      help: Temporary workaround. Whether to apply a fix from https://review.opendev.org/c/openstack/neutron/+/831511/
                      default: False

                  fix_tmp_dir_exec:
                      type: Bool
                      help: Temporary workaround. Whether to apply fix from https://code.engineering.redhat.com/gerrit/c/networking-ovn/+/401893/
                      default: False
