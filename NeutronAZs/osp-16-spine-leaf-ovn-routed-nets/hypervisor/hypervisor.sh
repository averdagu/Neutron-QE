infrared ssh hypervisor "sudo yum install -y dhcp*.x86_64"

infrared ssh hypervisor "sudo dhcrelay --no-pid 192.168.24.10  192.168.24.1"

infrared ssh hypervisor "sudo iptables -I FORWARD -s 192.168.34.0/24 -d 192.168.24.0/24 -j ACCEPT"
infrared ssh hypervisor "sudo iptables -I FORWARD -s 192.168.24.0/24 -d 192.168.34.0/24 -j ACCEPT"
infrared ssh hypervisor "sudo iptables -I FORWARD -s 192.168.24.0/24 -d 192.168.44.0/24 -j ACCEPT"
infrared ssh hypervisor "sudo iptables -I FORWARD -s 192.168.44.0/24 -d 192.168.24.0/24 -j ACCEPT"
infrared ssh hypervisor "sudo iptables -I FORWARD -j ACCEPT"

infrared ssh hypervisor "sudo iptables -t nat -I POSTROUTING -s 192.168.24.0/24 ! -d 192.168.24.0/24 -j MASQUERADE"
infrared ssh hypervisor "sudo iptables -t nat -I POSTROUTING -s 192.168.34.0/24 ! -d 192.168.34.0/24 -j MASQUERADE"
infrared ssh hypervisor "sudo iptables -t nat -I POSTROUTING -s 192.168.44.0/24 ! -d 192.168.44.0/24 -j MASQUERADE"

infrared ssh hypervisor "sudo ip link add link site-external name centrex.101 type vlan id 101"
infrared ssh hypervisor "sudo ip a add 10.101.10.1/24 dev centrex.101"
infrared ssh hypervisor "sudo ip link set dev centrex.101 up"

infrared ssh hypervisor "sudo ip link add link dcn1-external name dcn1ex.101 type vlan id 101"
infrared ssh hypervisor "sudo ip a add 10.101.20.1/24 dev dcn1ex.101"
infrared ssh hypervisor "sudo ip link set dev dcn1ex.101 up"

infrared ssh hypervisor "sudo ip link add link dcn2-external name dcn2ex.101 type vlan id 101"
infrared ssh hypervisor "sudo ip a add 10.101.30.1/24 dev dcn2ex.101"
infrared ssh hypervisor "sudo ip link set dev dcn2ex.101 up"

infrared ssh hypervisor "sudo ip link add link site-management name site.1188 type vlan id 1188"
infrared ssh hypervisor "sudo ip a add 172.18.1.254/24 dev site.1188"
infrared ssh hypervisor "sudo ip link set dev site.1188 up"

infrared ssh hypervisor "sudo ip link add link site-management name site.1189 type vlan id 1189"
infrared ssh hypervisor "sudo ip a add 172.19.1.254/24 dev site.1189"
infrared ssh hypervisor "sudo ip link set dev site.1189 up"

infrared ssh hypervisor "sudo ip link add link site-management name site.1183 type vlan id 1183"
infrared ssh hypervisor "sudo ip a add 172.23.1.254/24 dev site.1183"
infrared ssh hypervisor "sudo ip link set dev site.1183 up"

infrared ssh hypervisor "sudo ip link add link site-management name site.1185 type vlan id 1185"
infrared ssh hypervisor "sudo ip a add 172.25.1.254/24 dev site.1185"
infrared ssh hypervisor "sudo ip link set dev site.1185 up"

#################################################################
infrared ssh hypervisor "sudo ip link add link dcn1-management name dcn1.1178 type vlan id 1178"
infrared ssh hypervisor "sudo ip a add 172.18.2.254/24 dev dcn1.1178"
infrared ssh hypervisor "sudo ip link set dev dcn1.1178 up"

infrared ssh hypervisor "sudo ip link add link dcn1-management name dcn1.1179 type vlan id 1179"
infrared ssh hypervisor "sudo ip a add 172.19.2.254/24 dev dcn1.1179"
infrared ssh hypervisor "sudo ip link set dev dcn1.1179 up"


infrared ssh hypervisor "sudo ip link add link dcn1-management name dcn1.1173 type vlan id 1173"
infrared ssh hypervisor "sudo ip a add 172.23.2.254/24 dev dcn1.1173"
infrared ssh hypervisor "sudo ip link set dev dcn1.1173 up"

infrared ssh hypervisor "sudo ip link add link dcn1-management name dcn1.1175 type vlan id 1175"
infrared ssh hypervisor "sudo ip a add 172.25.2.254/24 dev dcn1.1175"
infrared ssh hypervisor "sudo ip link set dev dcn1.1175 up"
#################################################################
infrared ssh hypervisor "sudo ip link add link dcn2-management name dcn2.1168 type vlan id 1168"
infrared ssh hypervisor "sudo ip a add 172.18.3.254/24 dev dcn2.1168"
infrared ssh hypervisor "sudo ip link set dev dcn2.1168 up"

infrared ssh hypervisor "sudo ip link add link dcn2-management name dcn2.1169 type vlan id 1169"
infrared ssh hypervisor "sudo ip a add 172.19.3.254/24 dev dcn2.1169"
infrared ssh hypervisor "sudo ip link set dev dcn2.1169 up"

infrared ssh hypervisor "sudo ip link add link dcn2-management name dcn2.1163 type vlan id 1163"
infrared ssh hypervisor "sudo ip a add 172.23.3.254/24 dev dcn2.1163"
infrared ssh hypervisor "sudo ip link set dev dcn2.1163 up"

infrared ssh hypervisor "sudo ip link add link dcn2-management name dcn2.1165 type vlan id 1165"
infrared ssh hypervisor "sudo ip a add 172.25.3.254/24 dev dcn2.1165"
infrared ssh hypervisor "sudo ip link set dev dcn2.1165 up"
