#!/bin/bash


openstack overcloud deploy  \
--templates \
--timeout 75 \
-r /home/stack/ospd-12-multiple-nic-vlans-sriov-hybrid-ha-ovn/roles_data.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/network-isolation.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/host-config-and-reboot.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/neutron-sriov.yaml \
-e /home/stack/ospd-12-multiple-nic-vlans-sriov-hybrid-ha-ovn/docker-images.yaml \
-e /home/stack/ospd-12-multiple-nic-vlans-sriov-hybrid-ha-ovn/network-environment.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/neutron-ml2-ovn-ha.yaml \
--log-file overcloud_install.log &> overcloud_install.log
