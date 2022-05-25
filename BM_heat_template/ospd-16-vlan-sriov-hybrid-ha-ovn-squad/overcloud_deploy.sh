#!/bin/bash
if [[ ! -f "/home/stack/ospd-16-vlan-sriov-hybrid-ha-ovn-squad/roles_data.yaml" ]]; then
  openstack overcloud roles generate -o /home/stack/ospd-16-vlan-sriov-hybrid-ha-ovn-squad/roles_data.yaml ControllerSriov ComputeSriov
fi

openstack -vvv overcloud deploy  \
--templates \
--timeout 120 \
-r /home/stack/ospd-16-vlan-sriov-hybrid-ha-ovn-squad/roles_data.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/network-isolation.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/host-config-and-reboot.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/services/neutron-ovn-ha.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/services/neutron-ovn-sriov.yaml \
-e /home/stack/containers-prepare-parameter.yaml \
-e /home/stack/ospd-16-vlan-sriov-hybrid-ha-ovn-squad/api-policies.yaml \
-e /home/stack/ospd-16-vlan-sriov-hybrid-ha-ovn-squad/network-environment.yaml \
-e /home/stack/ospd-16-vlan-sriov-hybrid-ha-ovn-squad/os-net-config-mappings.yaml \
-e /home/stack/ospd-16-vlan-sriov-hybrid-ha-ovn-squad/nova-resize-on-the-same-host.yaml \
-e /home/stack/ospd-16-vlan-sriov-hybrid-ha-ovn-squad/l3_fip_qos.yaml \
-e /home/stack/ospd-16-vlan-sriov-hybrid-ha-ovn-squad/ovn-extras.yaml \
-e /home/stack/ospd-16-vlan-sriov-hybrid-ha-ovn-squad/docker-images.yaml \
--ntp-server clock.redhat.com,time1.google.com,time2.google.com,time3.google.com,time4.google.com \
--log-file overcloud_install.log &> overcloud_install.log
