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
ubuntu_int1_interface="br1_to_br-ubuntu1_patch"
ubuntu_int1_port=$(ssh $1 sudo ovs-vsctl get Interface $ubuntu_int1_interface ofport)

#ubuntu_int2_interface=$(ssh $1 virsh dumpxml ubuntu-int2 | grep -oP "vnet\d+")
ubuntu_int2_interface="br1_to_br-ubuntu2_patch"
ubuntu_int2_port=$(ssh $1 sudo ovs-vsctl get Interface $ubuntu_int2_interface ofport)



ubuntu_int1_port_clone=$(ssh $2 sudo ovs-vsctl get Interface $ubuntu_int1_interface ofport)

ubuntu_int2_port_clone=$(ssh $2 sudo ovs-vsctl get Interface $ubuntu_int2_interface ofport)



gre_r720_2=$(ssh $1 sudo ovs-vsctl get Interface r720_2_to_3.gre ofport)
gre_r720_3=$(ssh $2 sudo ovs-vsctl get Interface r720_3_to_2.gre ofport)
#dpid=$(sudo ovs-ofctl show br1 | grep -oP "dpid:.+" | sed 's/dpid://' | sed 's/\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3:\4:\5:\6:\7:\8/')

original_switch=$(ssh $1 sudo ovs-ofctl show br1 | grep -oP "dpid:.+" | sed 's/dpid://' | sed 's/\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3:\4:\5:\6:\7:\8/')
clone_switch=$(ssh $2 sudo ovs-ofctl show br1 | grep -oP "dpid:.+" | sed 's/dpid://' | sed 's/\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3:\4:\5:\6:\7:\8/')

#TODO: get OVS DPIDs in this manner as well
#TODO: set OVS controllers on hosts to here

#echo "ubuntu-int1 KVM network interface: $ubuntu_int1_interface"
echo "ubuntu-int1 OVS OF port: $ubuntu_int1_port"
#echo "ubuntu-int2 KVM network interface: $ubuntu_int2_interface"
echo "ubuntu-int2 KVM OF port: $ubuntu_int2_port"
echo "ubuntu-int1 clone OVS OF port: $ubuntu_int1_port_clone"
echo "ubuntu-int2 clone OVS OF port: $ubuntu_int2_port_clone"
echo "gre tunnel of r720-2 to r720-3 OF port on r720-2: $gre_r720_2"
echo "gre tunnel of r720-3 to r720-2 OF port on r720-3: $gre_r720_3"
echo "original switch dpid: $original_switch"
echo "clone switch dpid: $clone_switch"


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
python ovxctl.py -n createPort 1 $clone_switch $ubuntu_int1_port_clone
python ovxctl.py -n createPort 1 $clone_switch $ubuntu_int2_port_clone

#add ports on ovs to virtual switches - might need to change based on what ports are used?
#creates r720-2 gre tunnel port on port 1 of vswitch :01
python ovxctl.py -n createPort 1 $original_switch $gre_r720_2
#creates ubuntu-int1 port on port 2 of vswitch :01
python ovxctl.py -n createPort 1 $original_switch $ubuntu_int1_port
#creates ubuntu-int2 port on port 3 of vswitch :01
python ovxctl.py -n createPort 1 $original_switch $ubuntu_int2_port

#python ovxctl.py -n createPort 1 00:00:00:00:00:00:01:00 3 # this should create port 3 for vswitch 00:a4:23:05:00:00:00:03
#python ovxctl.py -n createPort 1 00:00:00:00:00:00:03:00 2 # this should create port 1 for vswitch 00:a4:23:05:00:00:00:03
#python ovxctl.py -n createPort 1 00:00:00:00:00:00:03:00 3 # this should create port 2 for vswitch 00:a4:23:05:00:00:00:03, we don't need this for now since we wont have host to connect to it
#python ovxctl.py -n createPort 1 00:00:00:00:00:00:03:00 3 # this should create port 3 for vswitch 00:a4:23:05:00:00:00:03


python ovxctl.py -n connectLink 1 00:a4:23:05:00:00:00:01 1 00:a4:23:05:00:00:00:02 1 spf 1


python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:01 2 52:54:00:aa:52:b8  #connect ubuntu-int1 to this switch
python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:01 3 52:54:00:49:a5:72  # connecting ubuntu-int2 to this vswitch

python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:02 2 0e:df:20:9f:19:88
python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:02 3 ce:5a:b9:7c:87:b5


#python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:02 1 52:54:00:c4:90:dd  #connect ubuntu-int1 to this switch
#python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:02 2 52:54:00:83:4d:44  # connecting ubuntu-int2 to this vswitch

echo "Now starting network..."
python ovxctl.py -n startNetwork 1
