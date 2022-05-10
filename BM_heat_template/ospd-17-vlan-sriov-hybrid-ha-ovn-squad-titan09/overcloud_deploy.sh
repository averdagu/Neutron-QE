#!/bin/bash
if [[ ! -f "/home/stack/ospd-17-vlan-sriov-hybrid-ha-ovn-squad-titan09/roles_data.yaml" ]]; then
  openstack overcloud roles generate -o /home/stack/ospd-17-vlan-sriov-hybrid-ha-ovn-squad-titan09/roles_data.yaml ControllerSriov ComputeSriov
fi

openstack -vvv overcloud deploy  \
--templates \
--timeout 120 \
-r /home/stack/ospd-17-vlan-sriov-hybrid-ha-ovn-squad-titan09/roles_data.yaml \
--deployed-server \
-e /home/stack/templates/overcloud-vip-deployed.yaml \
-e /home/stack/templates/overcloud-networks-deployed.yaml \
-e /home/stack/templates/overcloud-baremetal-deployed.yaml \
--networks-file /home/stack/ospd-17-vlan-sriov-hybrid-ha-ovn-squad-titan09/network/network_data_v2.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/services/neutron-ovn-ha.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/services/neutron-ovn-sriov.yaml \
-e /home/stack/containers-prepare-parameter.yaml \
-e /home/stack/ospd-17-vlan-sriov-hybrid-ha-ovn-squad-titan09/api-policies.yaml \
-e /home/stack/ospd-17-vlan-sriov-hybrid-ha-ovn-squad-titan09/network-environment.yaml \
-e /home/stack/ospd-17-vlan-sriov-hybrid-ha-ovn-squad-titan09/nova-resize-on-the-same-host.yaml \
-e /home/stack/ospd-17-vlan-sriov-hybrid-ha-ovn-squad-titan09/l3_fip_qos.yaml \
-e /home/stack/ospd-17-vlan-sriov-hybrid-ha-ovn-squad-titan09/ovn-extras.yaml \
--ntp-server clock.redhat.com,time1.google.com,time2.google.com,time3.google.com,time4.google.com \
--log-file overcloud_install.log &> overcloud_install.log
