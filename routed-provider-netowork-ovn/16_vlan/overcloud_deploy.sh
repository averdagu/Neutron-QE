#!/bin/bash

openstack overcloud deploy \
    --timeout 240 \
    --templates /usr/share/openstack-tripleo-heat-templates \
    --libvirt-type kvm \
    --stack overcloud \
    -r /home/stack/16_vlan/roles/roles_data.yaml \
    -n /home/stack/16_vlan/network/network_data.yaml \
    -e /usr/share/openstack-tripleo-heat-templates/environments/network-isolation.yaml \
    -e /usr/share/openstack-tripleo-heat-templates/environments/network-environment.yaml \
    -e /home/stack/16_vlan/os-net-config-mappings.yaml \
    -e /home/stack/16_vlan/network/network-environment-overrides.yaml \
    -e /home/stack/16_vlan/roles/nodes.yaml
