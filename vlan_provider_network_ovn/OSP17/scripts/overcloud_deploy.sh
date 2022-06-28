#!/bin/bash

if [[ ! -f "/home/stack/OSP17/roles_data.yaml" ]]; then
  openstack overcloud roles generate -o /home/stack/OSP17/roles_data.yaml Controller Compute Networker
fi

openstack overcloud deploy \
--timeout 240 \
--templates /usr/share/openstack-tripleo-heat-templates \
--libvirt-type kvm \
--stack overcloud \
-r /home/stack/OSP17/roles_data.yaml \
-n /home/stack/OSP17/network/network_data_v2.yaml \
--deployed-server \
-e /home/stack/templates/overcloud-vip-deployed.yaml \
-e /home/stack/templates/overcloud-networks-deployed.yaml \
-e /home/stack/templates/overcloud-baremetal-deployed.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/cinder-backup.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/services/neutron-ovn-dvr-ha.yaml \
-e /home/stack/OSP17/network/network-environment_v2.yaml \
-e /home/stack/OSP17/roles/nodes-17.yaml \
-e /home/stack/OSP17/ovn-extras.yaml \
-e /home/stack/OSP17/l3_fip_qos.yaml \
-e /home/stack/OSP17/performance.yaml \
-e /home/stack/OSP17/debug.yaml \
-e /home/stack/OSP17/hostnames.yaml \
-e /home/stack/OSP17/set-nova-scheduler-filter.yaml \
-e /home/stack/containers-prepare-parameter.yaml \
--ntp-server clock.redhat.com,time1.google.com,time2.google.com,time3.google.com,time4.google.com \
--log-file overcloud_install.log &> overcloud_install.log
