#!/bin/bash
THT_PATH='/home/stack/ospd-17-vlan-sriov-hybrid-ha-ovs-squad-titan13'

if [[ ! -f "$THT_PATH/roles_data.yaml" ]]; then
  openstack overcloud roles generate -o $THT_PATH/roles_data.yaml ControllerSriov ComputeSriov
fi

openstack -vvv overcloud deploy  \
--templates \
--timeout 120 \
--deployed-server \
-r /home/stack/ospd-17-vlan-sriov-hybrid-ha-ovs-titan13/roles_data.yaml \
-e /home/stack/templates/overcloud-vip-deployed.yaml \
-e /home/stack/templates/overcloud-networks-deployed.yaml \
-e /home/stack/templates/overcloud-baremetal-deployed.yaml \
--networks-file /home/stack/ospd-17-vlan-sriov-hybrid-ha-ovn-squad-titan13/network/network_data_v2.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/network-isolation.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/host-config-and-reboot.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/services/neutron-ovs.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/services/neutron-sriov.yaml \
-e /home/stack/ospd-17-vlan-sriov-hybrid-ha-ovs-titan13/l3_fip_qos.yaml \
-e /home/stack/ospd-17-vlan-sriov-hybrid-ha-ovs-titan13/dns.yaml \
-e /home/stack/ospd-17-vlan-sriov-hybrid-ha-ovs-titan13/floating_ip_port_forwarding.yaml \
-e /home/stack/ospd-17-vlan-sriov-hybrid-ha-ovs-titan13/nova-resize-on-the-same-host.yaml \
-e /home/stack/ospd-17-vlan-sriov-hybrid-ha-ovs-titan13/network-environment.yaml \
-e /home/stack/containers-prepare-parameter.yaml \
-e /home/stack/ospd-17-vlan-sriov-hybrid-ha-ovn-squad-titan13/api-policies.yaml \
--ntp-server clock.redhat.com,time1.google.com,time2.google.com,time3.google.com,time4.google.com \
--log-file overcloud_install.log &> overcloud_install.log
