#!/bin/bash

openstack overcloud deploy \
--timeout 240 \
--templates /usr/share/openstack-tripleo-heat-templates \
--libvirt-type kvm \
--stack overcloud \
--ntp-server clock.corp.redhat.com \
-r /home/stack/vlan_provider_network/roles/roles_data-16.yaml \
-n /home/stack/vlan_provider_network/network/network-config.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/cinder-backup.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/network-isolation.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/services/neutron-ovs-dvr.yaml \
-e /home/stack/vlan_provider_network/network/network-environment.yaml \
-e /home/stack/vlan_provider_network/roles/nodes-16.yaml \
-e /home/stack/vlan_provider_network/l3_fip_qos.yaml \
-e /home/stack/containers-prepare-parameter.yaml \
-e /home/stack/vlan_provider_network/debug.yaml \
-e /home/stack/vlan_provider_network/dns.yaml \
-e /home/stack/vlan_provider_network/ntp_pool.yaml \
-e /home/stack/vlan_provider_network/hostnames.yaml \
-e /home/stack/vlan_provider_network/config_heat.yaml \
-e /home/stack/vlan_provider_network/set-nova-scheduler-filter.yaml
