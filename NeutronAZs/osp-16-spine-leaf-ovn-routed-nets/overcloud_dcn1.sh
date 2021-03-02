source /home/stack/stackrc

sudo cp overcloud_deploy.sh overcloud_deploy_dcn1.sh
sudo cp /home/stack/central/config_lvm.yaml /home/stack/dcn1/config_lvm.yaml
#sudo cp /home/stack/central/enable-tls.yaml /home/stack/dcn1/enable-tls.yaml
sudo cp /home/stack/central/inject-trust-anchor.yaml /home/stack/dcn1/inject-trust-anchor.yaml
sudo cp /home/stack/central/hostnames.yml /home/stack/dcn1/hostnames.yml
sudo cp /home/stack/central/debug.yaml /home/stack/dcn1/debug.yaml
if [ -f "/home/stack/central/cloud-names.yaml" ]; then sudo cp /home/stack/central/cloud-names.yaml /home/stack/dcn1/cloud-names.yaml; fi
if [ -f "/home/stack/central/ipaservices-baremetal-ansible.yaml" ]; then sudo cp /home/stack/central/ipaservices-baremetal-ansible.yaml /home/stack/dcn1/ipaservices-baremetal-ansible.yaml; fi
if [ -f "/home/stack/central/barbican.yaml" ]; then sudo cp /home/stack/central/barbican.yaml /home/stack/dcn1/barbican.yaml; fi
if [ -f "/home/stack/central/glance-image-signing.yaml" ]; then sudo cp /home/stack/central/glance-image-signing.yaml /home/stack/dcn1/glance-image-signing.yaml; fi
if [ -f "/home/stack/central/glance-image-signing.yaml" ]; then sudo sed -i 's/Compute/Compute1/g' /home/stack/dcn1/glance-image-signing.yaml; fi
DNS=`grep -A1 DnsSer central/network/network-environment.yaml | tail -1| cut -d'-' -f2 | xargs`
sudo sed -i 's/services\/barbican.yaml/services\/barbican-edge.yaml/g' overcloud_deploy_dcn1.sh
sudo sed -i "s/10\.11\.5\.19/$DNS/g" /home/stack/dcn1/network/network-environment.yaml
sudo sed -i '/public_vip.yaml/d' overcloud_deploy_dcn1.sh
sudo sed -i '/overcloud_passwords.yaml/d' overcloud_deploy_dcn1.sh
sudo sed -i 's/central/dcn1/g' overcloud_deploy_dcn1.sh
sudo sed -i 's/overcloud_deployment/dcn1_overcloud_deployment/g' overcloud_deploy_dcn1.sh
sudo sed -i '/debug.yaml/ a -e /home/stack/central-export.yaml \\' overcloud_deploy_dcn1.sh
