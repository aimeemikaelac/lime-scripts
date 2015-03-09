#!/bin/sh
#$1 = ip address of r720-2 (original)
#$2 = ip address of r720-3 (clone)

if [ -z "$1" ];
	then echo "address of r720-2 must be provided";
	exit 1;
fi

if [ -z "$2" ];
	then echo "address of r720-3 must be provided";
	exit 1;
fi

#sudo ovs-ofctl show br1 | grep -Po '(?<=dpid:).+'

#ubuntu-int1 and 2 must be running to detect their ports
#TODO: start the vms here is they aren't running?
#ubuntu_int1_interface=$(ssh $1 virsh dumpxml ubuntu-int1 | grep -oP "vnet\d+")
ubuntu_int1_interface="ubuntu1.tap"
ubuntu_int1_port=$(ssh $1 sudo ovs-vsctl get Interface $ubuntu_int1_interface ofport)

#ubuntu_int2_interface=$(ssh $1 virsh dumpxml ubuntu-int2 | grep -oP "vnet\d+")
ubuntu_int2_interface="ubuntu2.tap"
ubuntu_int2_port=$(ssh $1 sudo ovs-vsctl get Interface $ubuntu_int2_interface ofport)



ubuntu_int1_port_clone=$(ssh $2 sudo ovs-vsctl get Interface $ubuntu_int1_interface ofport)

ubuntu_int2_port_clone=$(ssh $2 sudo ovs-vsctl get Interface $ubuntu_int2_interface ofport)



ubuntu_int3_interface="ubuntu3.tap"
ubuntu_int3_port=$(ssh $1 sudo ovs-vsctl get Interface $ubuntu_int3_interface ofport)

#ubuntu_int2_interface=$(ssh $1 virsh dumpxml ubuntu-int2 | grep -oP "vnet\d+")
ubuntu_int4_interface="ubuntu4.tap"
ubuntu_int4_port=$(ssh $1 sudo ovs-vsctl get Interface $ubuntu_int4_interface ofport)

ubuntu_int5_interface="ubuntu5.tap"
ubuntu_int5_port=$(ssh $1 sudo ovs-vsctl get Interface $ubuntu_int5_interface ofport)


ubuntu_int3_port_clone=$(ssh $2 sudo ovs-vsctl get Interface $ubuntu_int3_interface ofport)

ubuntu_int4_port_clone=$(ssh $2 sudo ovs-vsctl get Interface $ubuntu_int4_interface ofport)

ubuntu_int5_port_clone=$(ssh $2 sudo ovs-vsctl get Interface $ubuntu_int5_interface ofport)


gre_2_interface="r720_2_to_3.gre"
#gre_2_interface="br1_to_gre_patch"
gre_3_interface="r720_3_to_2.gre"
#gre_3_interface="br1_to_gre_patch"
br2_interface="br2.gre"
br3_interface="br3.gre"

#gre_r720_2=$(ssh $1 sudo ovs-vsctl get Interface r720_2_to_3.gre ofport)
gre_r720_2=$(ssh $1 sudo ovs-vsctl get Interface $gre_2_interface ofport)
#gre_r720_3=$(ssh $2 sudo ovs-vsctl get Interface r720_3_to_2.gre ofport)
gre_r720_3=$(ssh $2 sudo ovs-vsctl get Interface $gre_3_interface ofport)
#dpid=$(sudo ovs-ofctl show br1 | grep -oP "dpid:.+" | sed 's/dpid://' | sed 's/\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3:\4:\5:\6:\7:\8/')
br2_gre_r720_2=$(ssh $1 sudo ovs-vsctl get Interface $br2_interface ofport)
br2_gre_r720_3=$(ssh $2 sudo ovs-vsctl get Interface $br2_interface ofport)
br3_gre_r720_2=$(ssh $1 sudo ovs-vsctl get Interface $br3_interface ofport)
br3_gre_r720_3=$(ssh $2 sudo ovs-vsctl get Interface $br3_interface ofport)

br2_3_interface="br2_to_br3"
br2_3_r2=$(ssh $1 sudo ovs-vsctl get Interface $br2_3_interface ofport)
br2_3_r3=$(ssh $2 sudo ovs-vsctl get Interface $br2_3_interface ofport)

br3_2_interface="br3_to_br2"
br3_2_r2=$(ssh $1 sudo ovs-vsctl get Interface $br3_2_interface ofport)
br3_2_r3=$(ssh $2 sudo ovs-vsctl get Interface $br3_2_interface ofport)

br1_2_interface="br1_to_br2"
br1_2_r2=$(ssh $1 sudo ovs-vsctl get Interface $br1_2_interface ofport)
br1_2_r3=$(ssh $2 sudo ovs-vsctl get Interface $br1_2_interface ofport)

br2_1_interface="br2_to_br1"
br2_1_r2=$(ssh $1 sudo ovs-vsctl get Interface $br2_1_interface ofport)
br2_1_r3=$(ssh $2 sudo ovs-vsctl get Interface $br2_1_interface ofport)


dummy1=$(ssh $1 sudo ovs-vsctl get Interface dummy.tap ofport)
dummy2=$(ssh $2 sudo ovs-vsctl get Interface dummy.tap ofport)

dummy1_3=$(ssh $1 sudo ovs-vsctl get Interface dummy2.tap ofport)
dummy2_3=$(ssh $1 sudo ovs-vsctl get Interface dummy2.tap ofport)

original_switch=$(ssh $1 sudo ovs-ofctl show br1 | grep -oP "dpid:.+" | sed 's/dpid://' | sed 's/\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3:\4:\5:\6:\7:\8/')
clone_switch=$(ssh $2 sudo ovs-ofctl show br1 | grep -oP "dpid:.+" | sed 's/dpid://' | sed 's/\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3:\4:\5:\6:\7:\8/')

#TODO: get OVS DPIDs in this manner as well
#TODO: set OVS controllers on hosts to here

#echo "ubuntu-int1 KVM network interface: $ubuntu_int1_interface"
echo "ubuntu-int1 OVS OF port: $ubuntu_int1_port"
#echo "ubuntu-int2 KVM network interface: $ubuntu_int2_interface"
echo "ubuntu-int2 KVM OF port: $ubuntu_int2_port"
echo "ubuntu-int3 KVM OF port: $ubuntu_int3_port"
echo "ubuntu-int4 KVM OF port: $ubuntu_int4_port"
echo "ubuntu-int5 KVM OF port: $ubuntu_int5_port"
echo "ubuntu-int1 clone OVS OF port: $ubuntu_int1_port_clone"
echo "ubuntu-int2 clone OVS OF port: $ubuntu_int2_port_clone"
echo "ubuntu-int3 clone OVS OF port: $ubuntu_int3_port_clone"
echo "ubuntu-int4 clone OVS OF port: $ubuntu_int4_port_clone"
echo "ubuntu-int5 clone OVS OF port: $ubuntu_int5_port_clone"
echo "gre tunnel of r720-2 to r720-3 OF port on r720-2: $gre_r720_2"
echo "gre tunnel of r720-3 to r720-2 OF port on r720-3: $gre_r720_3"
echo "original switch dpid: $original_switch"
echo "clone switch dpid: $clone_switch"
echo "Dummy port 1: $dummy1"
echo "Dummy port 2: $dummy2"

#6633
python ovxctl.py -n createNetwork tcp:192.168.1.1:6633 192.168.3.1 24  #LIME address

#create first physical to ovx switch mapping. returns 00:a4:23:05:00:00:00:01 as ovx switch dpid
#python ovxctl.py -n createSwitch 1 00:00:00:00:00:00:01:00
#create using DPID of ubuntu-ngn-r720-2 ovs dpid
python ovxctl.py -n createSwitch 1 $original_switch

#create second physical to ovs switch mapping. returns 00:a4:23:05:00:00:00:02 as vx switch dpid
#python ovxctl.py -n createSwitch 1 00:00:00:00:00:00:02:00
#create using DPID of ubuntu-ngn-r720-3 ovs dpid
python ovxctl.py -n createSwitch 1 $clone_switch

#python ovxctl.py -n createSwitch 1 00:00:00:00:00:00:03:00


#creates r720-3 gre tunnel port on port 1 of vswitch :02
python ovxctl.py -n createPort 1 $clone_switch $gre_r720_3
#NOTE: needed so that the flow mods to receive the vlan tags can
#be written before the hosts are migrated. will still need to 
#disconnect and reconnect each host individually in ovx. may
#be good to put all of this in the Java code
#TODO: need to get the ports on the clone, which will not exist yet
#need to go back to using the ovs bridges for each host
#the issue of the packets not being seen by the controller may occur,
#as the mac address may not be that of the host, but of the patch port sending
#the packet. can replace the host macs with the patch port mac, which
#can be done via script here
echo "ubuntu-int1 original:"
python ovxctl.py -n createPort 1 $clone_switch $ubuntu_int1_port_clone
echo "ubuntu-int2 original:"
python ovxctl.py -n createPort 1 $clone_switch $ubuntu_int2_port_clone
python ovxctl.py -n createPort 1 $clone_switch $ubuntu_int3_port_clone
python ovxctl.py -n createPort 1 $clone_switch $ubuntu_int4_port_clone
python ovxctl.py -n createPort 1 $clone_switch $ubuntu_int5_port_clone
python ovxctl.py -n createPort 1 $clone_switch $dummy2
#TEST: create another  port on a physical port
#python ovxctl.py -n createPort 1 $clone_switch $gre_r720_3

#add ports on ovs to virtual switches - might need to change based on what ports are used?
#creates r720-2 gre tunnel port on port 1 of vswitch :01
echo "ubuntu-int1 clone:"
python ovxctl.py -n createPort 1 $original_switch $gre_r720_2
#creates ubuntu-int1 port on port 2 of vswitch :01
echo "ubuntu-int2 clone:"
python ovxctl.py -n createPort 1 $original_switch $ubuntu_int1_port
#creates ubuntu-int2 port on port 3 of vswitch :01
python ovxctl.py -n createPort 1 $original_switch $ubuntu_int2_port
python ovxctl.py -n createPort 1 $original_switch $ubuntu_int3_port
python ovxctl.py -n createPort 1 $original_switch $ubuntu_int4_port
python ovxctl.py -n createPort 1 $original_switch $ubuntu_int5_port
python ovxctl.py -n createPort 1 $original_switch $dummy1
#ANOTHER TEST:
#python ovxctl.py -n createPort 1 $original_switch $gre_r720_2

#python ovxctl.py -n createPort 1 00:00:00:00:00:00:01:00 3 # this should create port 3 for vswitch 00:a4:23:05:00:00:00:03
#python ovxctl.py -n createPort 1 00:00:00:00:00:00:03:00 2 # this should create port 1 for vswitch 00:a4:23:05:00:00:00:03
#python ovxctl.py -n createPort 1 00:00:00:00:00:00:03:00 3 # this should create port 2 for vswitch 00:a4:23:05:00:00:00:03, we don't need this for now since we wont have host to connect to it
#python ovxctl.py -n createPort 1 00:00:00:00:00:00:03:00 3 # this should create port 3 for vswitch 00:a4:23:05:00:00:00:03


python ovxctl.py -n connectLink 1 00:a4:23:05:00:00:00:01 1 00:a4:23:05:00:00:00:02 1 spf 1
#TEST create duplicate link
#python ovxctl.py -n connectLink 1 00:a4:23:05:00:00:00:01 4 00:a4:23:05:00:00:00:02 4 spf 1
#python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:01 1 ce:5a:b9:7c:87:b9 #connect something to gre tunnel for now

echo "ubuntu-int1 original host#:"
python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:01 2 52:54:00:aa:52:b8  #connect ubuntu-int1 to this switch
echo "ubuntu-int2 original host#:"
python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:01 3 52:54:00:49:a5:72  # connecting ubuntu-int2 to this vswitch
python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:01 4 52:54:00:f5:e0:11  # connecting ubuntu-int3 to this vswitch
python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:01 5 52:54:00:43:cb:e3  # connecting ubuntu-int4 to this vswitch
python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:01 6 52:54:00:59:80:71  # connecting ubuntu-int5 to this vswitch
python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:01 7 ce:5a:b9:7c:87:b4 #connect something to dummy port

#connect dummy tap devices to these ports so that rules can be written to them. does not seem that the device needs exist?
#python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:02 1 ce:5a:b9:7c:87:ba #connect something to gre for now
echo "ubuntu-int1 host placeholder #:"
python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:02 2 52:54:00:75:5c:dd
echo "ubuntu-int2 host placeholder #:"
python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:02 3 ce:5a:b9:7c:87:b5
echo "ubuntu-int3 host placeholder #:"
python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:02 4 ce:5a:b9:7c:87:b6
echo "ubuntu-int4 host placeholder #:"
python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:02 5 ce:5a:b9:7c:87:b7
echo "ubuntu-int5 host placeholder #:"
python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:02 6 ce:5a:b9:7c:87:b8
python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:02 7 ff:ff:ff:ff:ff:ff #connect something to dummy port

python ovxctl.py -n startPort 1 00:a4:23:05:00:00:00:01 7
python ovxctl.py -n startPort 1 00:a4:23:05:00:00:00:02 7

#python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:02 1 52:54:00:c4:90:dd  #connect ubuntu-int1 to this switch
#python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:02 2 52:54:00:83:4d:44  # connecting ubuntu-int2 to this vswitch

echo "Now starting network..."
python ovxctl.py -n startNetwork 1
