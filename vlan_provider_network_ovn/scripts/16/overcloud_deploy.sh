#!/bin/bash

openstack overcloud deploy \
--timeout 240 \
--templates /usr/share/openstack-tripleo-heat-templates \
--libvirt-type kvm \
--stack overcloud \
--ntp-server clock.corp.redhat.com \
-r /home/stack/vlan_provider_network_ovn/roles/roles_data-16.yaml \
-n /home/stack/vlan_provider_network_ovn/network/network-config.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/cinder-backup.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/network-isolation.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/services/neutron-ovn-dvr-ha.yaml \
-e /home/stack/vlan_provider_network_ovn/network/network-environment.yaml \
-e /home/stack/vlan_provider_network_ovn/roles/nodes-16.yaml \
-e /home/stack/vlan_provider_network_ovn/ovn-extras.yaml \
-e /home/stack/vlan_provider_network_ovn/l3_fip_qos.yaml \
-e /home/stack/containers-prepare-parameter.yaml \
-e /home/stack/vlan_provider_network_ovn/performance.yaml \
-e /home/stack/vlan_provider_network_ovn/debug.yaml \
-e /home/stack/vlan_provider_network_ovn/hostnames.yaml \
-e /home/stack/vlan_provider_network_ovn/set-nova-scheduler-filter.yaml
