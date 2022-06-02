#!/bin/bash
THT_PATH='/home/stack/ospd-17-vlan-sriov-hybrid-ha-ovs-squad-titan09'

if [[ ! -f "$THT_PATH/roles_data.yaml" ]]; then
  openstack overcloud roles generate -o $THT_PATH/roles_data.yaml ControllerSriov ComputeSriov
fi

openstack -vvv overcloud deploy  \
--templates \
--timeout 120 \
--deployed-server \
-r /home/stack/ospd-17-vlan-sriov-hybrid-ha-ovs-squad-titan09/roles_data.yaml \
-e /home/stack/templates/overcloud-vip-deployed.yaml \
-e /home/stack/templates/overcloud-networks-deployed.yaml \
-e /home/stack/templates/overcloud-baremetal-deployed.yaml \
--networks-file $THT_PATH/network/network_data_v2.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/services/neutron-ovs.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/services/neutron-sriov.yaml \
-e $THT_PATH/l3_fip_qos.yaml \
-e $THT_PATH/dns.yaml \
-e $THT_PATH/floating_ip_port_forwarding.yaml \
-e $THT_PATH/nova-resize-on-the-same-host.yaml \
-e $THT_PATH/network-environment.yaml \
-e /home/stack/containers-prepare-parameter.yaml \
-e $THT_PATH/api-policies.yaml \
--ntp-server clock.redhat.com,time1.google.com,time2.google.com,time3.google.com,time4.google.com \
--log-file overcloud_install.log &> overcloud_install.log
