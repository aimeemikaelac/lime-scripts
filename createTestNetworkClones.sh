#!/bin/sh
#$1 = ip address of r720-3 (clone)

if [ -z "$1" ];
	then echo "address of r720-3 must be provided";
	exit 1;
fi

original_switch=$(ssh $1 sudo ovs-ofctl show br1 | grep -oP "dpid:.+" | sed 's/dpid://' | sed 's/\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3:\4:\5:\6:\7:\8/')
clone_switch=$(ssh $2 sudo ovs-ofctl show br1 | grep -oP "dpid:.+" | sed 's/dpid://' | sed 's/\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3:\4:\5:\6:\7:\8/')

#migration of vms must have finished
#TODO: start migration at this point?
ubuntu_int1_interface=$(ssh $1 virsh dumpxml ubuntu-int1 | grep -oP "vnet\d+")
ubuntu_int1_port=$(ssh $1 sudo ovs-vsctl get Interface $ubuntu_int1_interface ofport)
 
ubuntu_int2_interface=$(ssh $1 virsh dumpxml ubuntu-int2 | grep -oP "vnet\d+")
ubuntu_int2_port=$(ssh $1 sudo ovs-vsctl get Interface $ubuntu_int2_interface ofport)

echo "ubuntu-int1 KVM network interface: $ubuntu_int1_interface"
echo "ubuntu-int1 OVS OF port: $ubuntu_int1_port"
echo "ubuntu-int2 KVM network interface: $ubuntu_int2_interface"
echo "ubuntu-int2 OVS OF port: $ubuntu_int2_port"
echo "original switch dpid: $original_switch"
echo "clone switch dpid: $clone_switch"
 
#python ovxctl.py -n createSwitch 1 00:00:f2:22:2a:a1:e4:48

#python ovxctl.py -n disconnectHost 1 1
#python ovxctl.py -n disconnectHost 1 2

#python ovxctl.py -n stopNetwork 1

python ovxctl.py -n createPort 1 $clone_switch $ubuntu_int1_port
python ovxctl.py -n createPort 1 $clone_switch $ubuntu_int2_port

python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:02 2 52:54:00:39:c8:b4
python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:02 3 52:54:00:11:bb:bd

#python ovxctl.py -n startNetwork 1

echo "Now starting clone network..."
