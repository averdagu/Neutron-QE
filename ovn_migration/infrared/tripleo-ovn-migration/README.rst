Infrared plugin to carry out migration from ML2OVS to OVN
=========================================================

This is an infrared plugin which can be used to carry out the migration
from ML2OVS to OVN if the tripleo was deployed using infrared.
See http://infrared.readthedocs.io/en/stable/index.html for more information.

Before using this plugin, first deploy an ML2OVS overcloud and then:

1. On your undercloud, install python-networking-ovn-migration-tool package

2. Run ::
   infrared plugin add https://code.engineering.redhat.com/gerrit/Neutron-QE

3. Start migration by running::
   infrared  tripleo-ovn-migration

Using this as a standalone playbook for tripleo deployments
===========================================================
It is also possible to use the playbook main.yml with tripleo deployments.
In order to use this:

1. Create hosts inventory file like below
[undercloud]
undercloud_ip ansible_ssh_user=stack

2. Run the playbook as:
ansible-playbook main.yml  -i hosts
