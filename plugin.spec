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
                          sriov_ext: as sriov_ext_no_pf but creates also VMs with SR-IOV PF(direct-physical) ports
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
                        - sriov_ext
                        - trunk
                        - trunk_ext
                      default: normal

                  external_network:
                      type: Value
                      help: External network name to use
                      default: public

                  image_name:
                      type: Value
                      help: Image name to use
                      default: cirros-0.5.2-x86_64-disk.img

                  server_user_name:
                      type: Value
                      help: User name to use for login to the resources VMs
                      default: cirros

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

                  validate_migration:
                      type: Bool
                      help: Whether to run migration with validation or not.
                      default: True

                  fix_workload_mtu:
                      type: Bool
                      help: Whether to go over all workload VMs and reduce MTU before starting the migration.
                      default: False

                  geneve:
                      type: Bool
                      help: Whether to change tunnel to geneve.
                      default: True
