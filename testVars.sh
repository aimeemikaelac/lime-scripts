#!/bin/sh
#$1 = ip address of r720-2
#$2 = ip address of r720-3

#ubuntu-int1 and 2 must be running to detect their ports
#TODO: start the vms here is they aren't running?
ubuntu_int1_interface=$(ssh $1 virsh dumpxml ubuntu-int1 | grep -oP "vnet\d+")
ubuntu_int1_port=$(ssh $1 sudo ovs-vsctl get Interface $ubuntu_int1_interface ofport)

ubuntu_int2_interface=$(ssh $1 virsh dumpxml ubuntu-int2 | grep -oP "vnet\d+")
ubuntu_int2_port=$(ssh $1 sudo ovs-vsctl get Interface $ubuntu_int2_interface ofport)

gre_r720_2=$(ssh $1 sudo ovs-vsctl get Interface guest.gre ofport)
gre_r720_3=$(ssh $2 sudo ovs-vsctl get Interface guest.gre ofport)

echo "$ubuntu_int1_interface"
echo "$ubuntu_int1_port"
echo "$ubuntu_int2_interface"
echo "$ubuntu_int2_port"
echo "$gre_r720_2"
echo "$gre_r720_3"
