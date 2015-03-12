#!/bin/sh
#$r720_2 = ip address of r720-2 (original)
#$r720_3 = ip address of r720-3 (clone)

#if [ -z "$r720_2" ];
#	then echo "address of r720-2 must be provided";
#	exit 1;
#fi

#if [ -z "$r720_3" ];
#	then echo "address of r720-3 must be provided";
#	exit 1;
#fi

r720_2="128.138.189.249"
r720_3="128.138.189.140"

ovs_br1="192.168.1.101"
ovs_br2="192.168.1.102"
ovs_br3="192.168.1.103"
ovs_c_br1="192.168.1.201"
ovs_c_br2="192.168.1.202"
ovs_c_br3="192.168.1.203"

#ovs port # of ubuntu1 - connected to eth1 in ovs vm br1
ubuntu_int1_interface="eth1"
ubuntu_int1_port=$(ssh $ovs_br1 sudo ovs-vsctl get Interface $ubuntu_int1_interface ofport)
echo "ubuntu-int1 OVS OF port: $ubuntu_int1_port"

#ovs port number of ubuntu2 - connected to eth2 in ovs vm br1
ubuntu_int2_interface="eth2"
ubuntu_int2_port=$(ssh $ovs_br1 sudo ovs-vsctl get Interface $ubuntu_int2_interface ofport)
echo "ubuntu-int2 OVS OF port: $ubuntu_int2_port"

#ovs port number of ubuntu3 - connected to eth3 in ovs vm br1
ubuntu_int3_interface="eth3"
ubuntu_int3_port=$(ssh $ovs_br1 sudo ovs-vsctl get Interface $ubuntu_int3_interface ofport)
echo "ubuntu-int3 OVS OF port: $ubuntu_int3_port"

#ovs port number of ubuntu4 - connected to eth1 in ovs vm br3
ubuntu_int4_interface="eth1"
ubuntu_int4_port=$(ssh $ovs_br3 sudo ovs-vsctl get Interface $ubuntu_int4_interface ofport)
echo "ubuntu-int4 OVS OF port: $ubuntu_int4_port"

#ovs port number of ubuntu5 - connected to eth2 in ovs vm br3
ubuntu_int5_interface="eth2"
ubuntu_int5_port=$(ssh $ovs_br3 sudo ovs-vsctl get Interface $ubuntu_int5_interface ofport)
echo "ubuntu-int5 OVS OF port: $ubuntu_int5_port"

#ovs port number of ubuntu1 clone - connected to same port in ovs vm c_br1
ubuntu_int1_port_clone=$(ssh $ovs_c_br1 sudo ovs-vsctl get Interface $ubuntu_int1_interface ofport)
echo "ubuntu-int1 clone OVS OF port: $ubuntu_int1_port_clone"

#ovs port number of ubuntu2 clone - connected to same port in ovs c_br1
ubuntu_int2_port_clone=$(ssh $ovs_c_br1 sudo ovs-vsctl get Interface $ubuntu_int2_interface ofport)
echo "ubuntu-int2 clone OVS OF port: $ubuntu_int2_port_clone"

#ovs port number of ubuntu3 clone - connected to same port on ovs c_br1
ubuntu_int3_port_clone=$(ssh $ovs_c_br1 sudo ovs-vsctl get Interface $ubuntu_int3_interface ofport)
echo "ubuntu-int3 clone OVS OF port: $ubuntu_int3_port_clone"

#ovs port number of ubuntu4 clone - connected to same port on ovs c_br3
ubuntu_int4_port_clone=$(ssh $ovs_c_br3 sudo ovs-vsctl get Interface $ubuntu_int4_interface ofport)
echo "ubuntu-int4 clone OVS OF port: $ubuntu_int4_port_clone"

#ovs port number of ubuntu5 clone - connected to same port on ovs c_br3
ubuntu_int5_port_clone=$(ssh $ovs_c_br3 sudo ovs-vsctl get Interface $ubuntu_int5_interface ofport)
echo "ubuntu-int5 clone OVS OF port: $ubuntu_int5_port_clone"

#ghost port between br1 and c_br1
br1_to_c_br1=$(ssh $ovs_br1 sudo ovs-vsctl get Interface br1_to_c_br1 ofport)
echo "br1 gre tunnel to c_br1 OF port: $br1_to_c_br1"
c_br1_to_br1=$(ssh $ovs_c_br1 sudo ovs-vsctl get Interface c_br1_to_br1 ofport)
echo "c_br1 gre tunnel to br1 OF port: $c_br1_to_br1"

#ghost port between br2 and c_br2
br2_to_c_br2=$(ssh $ovs_br2 sudo ovs-vsctl get Interface br2_to_c_br2 ofport)
echo "br2 gre tunnel to c_br2 OF port: $br2_to_c_br2"
c_br2_to_br2=$(ssh $ovs_c_br2 sudo ovs-vsctl get Interface c_br2_to_br2 ofport)
echo "c_br2 gre tunnel to br2 OF port: $c_br2_to_br2"

#ghost port between br3 and c_br3
br3_to_c_br3=$(ssh $ovs_br3 sudo ovs-vsctl get Interface br3_to_c_br3 ofport)
echo "br3 gre tunnel to br3 OF port: $br3_to_c_br3"
c_br3_to_br3=$(ssh $ovs_c_br3 sudo ovs-vsctl get Interface c_br3_to_br3 ofport)
echo "c_br3 gre tunnel to br3 OF port: $c_br3_to_br3"

#switch connection between br1 and br2
br1_to_br2=$(ssh $ovs_br1 sudo ovs-vsctl get Interface br1_to_br2 ofport)
echo "br1 to br2 connection: $br1_to_br2"
br2_to_br1=$(ssh $ovs_br2 sudo ovs-vsctl get Interface br2_to_br1 ofport)
echo "br2 to br1 connection: $br2_to_br1"

#switch connection between br2 and br3
br2_to_br3=$(ssh $ovs_br2 sudo ovs-vsctl get Interface br2_to_br3 ofport)
echo "br2 to br3 connection: $br2_to_br3"
br3_to_br2=$(ssh $ovs_br3 sudo ovs-vsctl get Interface br3_to_br2 ofport)
echo "br3 to br2 connection: $br3_to_br2"

#switch connection between c_br1 and c_br2
c_br1_to_c_br2=$(ssh $ovs_c_br1 sudo ovs-vsctl get Interface c_br1_to_c_br2 ofport)
echo "c_br1 to c_br2 connection: $c_br1_to_c_br2"
c_br2_to_c_br1=$(ssh $ovs_c_br2 sudo ovs-vsctl get Interface c_br2_to_c_br1 ofport)
echo "c_br2 to c_br1 connection: $c_br2_to_c_br1"

#switch connection between c_br2 and c_br3
c_br2_to_c_br3=$(ssh $ovs_c_br2 sudo ovs-vsctl get Interface c_br2_to_c_br3 ofport)
echo "c_br2 to c_br3 connection: $c_br2_to_c_br3"
c_br3_to_c_br2=$(ssh $ovs_c_br3 sudo ovs-vsctl get Interface c_br3_to_c_br2 ofport)
echo "c_br3 to c_br2 connection: $c_br3_to_c_br2"

#br1 and c_br1 dummy
br1_dummy=$(ssh $ovs_br1 sudo ovs-vsctl get Interface dummy.tap ofport)
echo "original br1 dummy port: $br1_dummy"
br1_c_dummy=$(ssh $ovs_c_br1 sudo ovs-vsctl get Interface dummy.tap ofport)
echo "clone br1 dummy port: $br1_c_dummy"

#br2 and c_br2 dummy
br2_dummy=$(ssh $ovs_br2 sudo ovs-vsctl get Interface dummy.tap ofport)
echo "original br2 dummy port: $br2_dummy"
br2_c_dummy=$(ssh $ovs_c_br2 sudo ovs-vsctl get Interface dummy.tap ofport)
echo "clone br2 dummy port: $br2_c_dummy"

#br3 and c_br3
br3_dummy=$(ssh $ovs_br3 sudo ovs-vsctl get Interface dummy.tap ofport)
echo "original br3 dummy port: $br3_dummy"
br3_c_dummy=$(ssh $ovs_c_br3 sudo ovs-vsctl get Interface dummy.tap ofport)
echo "clone br3 dummy port: $br3_c_dummy"

#get original dpids
br1_dpid=$(ssh $ovs_br1 sudo ovs-ofctl show br1 | grep -oP "dpid:.+" | sed 's/dpid://' | sed 's/\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3:\4:\5:\6:\7:\8/')
echo "original br1 dpid: $br1_dpid"
br2_dpid=$(ssh $ovs_br2 sudo ovs-ofctl show br2 | grep -oP "dpid:.+" | sed 's/dpid://' | sed 's/\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3:\4:\5:\6:\7:\8/')
echo "original br2 dpid: $br2_dpid"
br3_dpid=$(ssh $ovs_br3 sudo ovs-ofctl show br3 | grep -oP "dpid:.+" | sed 's/dpid://' | sed 's/\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3:\4:\5:\6:\7:\8/')
echo "original br3 dpid: $br3_dpid"

#get clone dpids
clone_br1_dpid=$(ssh $ovs_c_br1 sudo ovs-ofctl show c_br1 | grep -oP "dpid:.+" | sed 's/dpid://' | sed 's/\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3:\4:\5:\6:\7:\8/')
echo "clone br1 dpid: $clone_br1_dpid"
clone_br2_dpid=$(ssh $ovs_c_br2 sudo ovs-ofctl show c_br2 | grep -oP "dpid:.+" | sed 's/dpid://' | sed 's/\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3:\4:\5:\6:\7:\8/')
echo "clone br2 dpid: $clone_br2_dpid"
clone_br3_dpid=$(ssh $ovs_c_br3 sudo ovs-ofctl show c_br3 | grep -oP "dpid:.+" | sed 's/dpid://' | sed 's/\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3:\4:\5:\6:\7:\8/')
echo "clone br3 dpid: $clone_br3_dpid"

################################################################
#Print gathered information
################################################################

python ovxctl.py -n createNetwork tcp:192.168.1.1:6633 192.168.3.1 24  #LIME address

################################################################
#Create OVX switches
################################################################

#create first physical to ovx switch mapping. returns 00:a4:23:05:00:00:00:01 as first ovx switch dpid
#00:a4:23:05:00:00:00:01 -> switch br1
python ovxctl.py -n createSwitch 1 $br1_dpid
br1="00:a4:23:05:00:00:00:01"
#00:a4:23:05:00:00:00:02 -> switch br2
python ovxctl.py -n createSwitch 1 $br2_dpid
br2="00:a4:23:05:00:00:00:02"
#00:a4:23:05:00:00:00:03 -> switch br3
python ovxctl.py -n createSwitch 1 $br3_dpid
br3="00:a4:23:05:00:00:00:03"

#00:a4:23:05:00:00:00:04
python ovxctl.py -n createSwitch 1 $clone_br1_dpid
c_br1="00:a4:23:05:00:00:00:04"
#00:a4:23:05:00:00:00:05
python ovxctl.py -n createSwitch 1 $clone_br2_dpid
c_br2="00:a4:23:05:00:00:00:05"
#00:a4:23:05:00:00:00:06
python ovxctl.py -n createSwitch 1 $clone_br3_dpid
c_br3="00:a4:23:05:00:00:00:06"

##############################################################
#Clone switches
##############################################################
#creates r720-3 gre tunnel port on port 1 of vswitch c_br1
python ovxctl.py -n createPort 1 $clone_br1_dpid $c_br1_to_br1
#same on c_br2
python ovxctl.py -n createPort 1 $clone_br2_dpid $c_br2_to_br2
#same on c_br3
python ovxctl.py -n createPort 1 $clone_br3_dpid $c_br3_to_br3

#create port 2 on c_br1 - the connection to c_br2
python ovxctl.py -n createPort 1 $clone_br1_dpid $c_br1_to_c_br2
#create port 3 on c_br1 - ubuntu-int1 clone
python ovxctl.py -n createPort 1 $clone_br1_dpid $ubuntu_int1_port_clone
#create port 4 on c_br1 - ubuntu-int2 clone
python ovxctl.py -n createPort 1 $clone_br1_dpid $ubuntu_int2_port_clone
#create port 5 on c_br1 - ubuntu-int3 clone
python ovxctl.py -n createPort 1 $clone_br1_dpid $ubuntu_int3_port_clone
#create port 6 on c_br1 - dummy
python ovxctl.py -n createPort 1 $clone_br1_dpid $br1_c_dummy


#create port 2 on c_br2 - the connection to c_br1
python ovxctl.py -n createPort 1 $clone_br2_dpid $c_br2_to_c_br1
#create port 3 on c_br2 - the connection to c_br3
python ovxctl.py -n createPort 1 $clone_br2_dpid $c_br2_to_c_br3
#create port 4 on c_br3 - dummy
python ovxctl.py -n createPort 1 $clone_br2_dpid $br2_c_dummy

#create port 2 on c_br3 - the connection to c_br2
python ovxctl.py -n createPort 1 $clone_br3_dpid $c_br3_to_c_br2
#create port 3 on c_br3 - ubuntu-int4 clone
python ovxctl.py -n createPort 1 $clone_br3_dpid $ubuntu_int4_port_clone
#create port 4 on c_br3 - ubuntu-int5 clone
python ovxctl.py -n createPort 1 $clone_br3_dpid $ubuntu_int5_port_clone
#create port 5 on c_br3 - dummy
python ovxctl.py -n createPort 1 $clone_br3_dpid $br3_c_dummy
################################################################
#Original switches
################################################################
#create r720-2 gre tunnel on port 1 of vswitch br1
python ovxctl.py -n createPort 1 $br1_dpid $br1_to_c_br1
#same in br2
python ovxctl.py -n createPort 1 $br2_dpid $br2_to_c_br2
#same in br3
python ovxctl.py -n createPort 1 $br3_dpid $br3_to_c_br3

#create port 2 on br1 - the connection to br2
python ovxctl.py -n createPort 1 $br1_dpid $br1_to_br2
#create port 3 on br1 - ubuntu-int1
python ovxctl.py -n createPort 1 $br1_dpid $ubuntu_int1_port
#create port 4 on br1 - ubuntu-int2
python ovxctl.py -n createPort 1 $br1_dpid $ubuntu_int2_port
#create port 5 on br1 - ubuntu-int3
python ovxctl.py -n createPort 1 $br1_dpid $ubuntu_int3_port
#create port 6 on br1 - dummy
python ovxctl.py -n createPort 1 $br1_dpid $br1_dummy

#create port 2 on br2 - the connection to br1
python ovxctl.py -n createPort 1 $br2_dpid $br2_to_br1
#create port 3 on br2 - the connection to br3
python ovxctl.py -n createPort 1 $br2_dpid $br2_to_br3
#create port 4 on br3 - dummy
python ovxctl.py -n createPort 1 $br2_dpid $br2_dummy

#create port 2 on br3 - the connection to br2
python ovxctl.py -n createPort 1 $br3_dpid $br3_to_br2
#create port 3 on br3 - ubuntu-int4
python ovxctl.py -n createPort 1 $br3_dpid $ubuntu_int4_port
#create port 4 on br3 - ubuntu-int5
python ovxctl.py -n createPort 1 $br3_dpid $ubuntu_int5_port
#create port 5 on br3 - dummy
python ovxctl.py -n createPort 1 $br3_dpid $br3_dummy
################################################################
#Ghost links
################################################################

python ovxctl.py -n connectLink 1 $br1 1 $c_br1 1 spf 1
python ovxctl.py -n connectLink 1 $br2 1 $c_br2 1 spf 1
python ovxctl.py -n connectLink 1 $br3 1 $c_br3 1 spf 1

python ovxctl.py -n connectLink 1 $br1 2 $br2 2 spf 1
python ovxctl.py -n connectLink 1 $br2 3 $br3 2 spf 1

python ovxctl.py -n connectLink 1 $c_br1 2 $c_br2 2 spf 1
python ovxctl.py -n connectLink 1 $c_br2 3 $c_br3 2 spf 1

################################################################
#Connect hosts
################################################################
int1_mac="52:54:00:aa:52:b8"
int2_mac="52:54:00:49:a5:72"
int3_mac="52:54:00:f5:e0:11"
int4_mac="52:54:00:43:cb:e3"
int5_mac="52:54:00:59:80:71"

int1_placeholder="52:54:00:75:5c:dd"
int2_placeholder="ce:5a:b9:7c:87:b5"
int3_placeholder="ce:5a:b9:7c:87:b6"
int4_placeholder="ce:5a:b9:7c:87:b7"
int5_placeholder="ce:5a:b9:7c:87:b8"

broadcast="ff:ff:ff:ff:ff:ff"

echo "ubuntu-int1 original host#:"
#connect ubuntu-int1 to br1:3
python ovxctl.py -n connectHost 1 $br1 3 $int1_mac
echo "ubuntu-int2 original host#:"
#connect ubuntu-int2 to br1:4
python ovxctl.py -n connectHost 1 $br1 4 $int2_mac
echo "ubuntu-int3 original host#:"
#connect ubuntu-int3 to br1:5
python ovxctl.py -n connectHost 1 $br1 5 $int3_mac
#manually start dummy port on br1
python ovxctl.py -n startPort 1 $br1 6

#manually start dummy port on br2
python ovxctl.py -n startPort 1 $br2 4

echo "ubuntu-int4 original host#:"
#connect ubuntu-int4 to br3:3
python ovxctl.py -n connectHost 1 $br3 3 $int4_mac  
echo "ubuntu-int5 original host#:"
#connect ubuntu-int5 to br3:4
python ovxctl.py -n connectHost 1 $br3 4 $int5_mac
#manually start dummy port on br3
python ovxctl.py -n startPort 1 $br3 5



echo "ubuntu-int1 host placeholder #:"
#connect ubuntu-int1-placeholder to c_br1:3
python ovxctl.py -n connectHost 1 $c_br1 3 $int1_placeholder
echo "ubuntu-int2 host placeholder #:"
#connect ubuntu-int2-placeholder to c_br1:4
python ovxctl.py -n connectHost 1 $c_br1 4 $int2_placeholder
echo "ubuntu-int3 host placeholder #:"
#connect ubuntu-int3-placeholder to c_br1:5
python ovxctl.py -n connectHost 1 $c_br1 5 $int3_placeholder
#manually start dummy port on c_br1
python ovxctl.py -n startPort 1 $c_br1 6

#manually start dummy port on c_br2
python ovxctl.py -n startPort 1 $c_br2 4

echo "ubuntu-int4 host placeholder #:"
#connect ubuntu-int4-placeholder to c_br3:3
python ovxctl.py -n connectHost 1 $c_br3 3 $int4_placeholder
echo "ubuntu-int5 host placeholder #:"
#connect ubuntu-int5-plcaeholder to c_br3:4
python ovxctl.py -n connectHost 1 $c_br3 4 $int5_placeholder
#manually start dummy port on c_br3
#python ovxctl.py -n startPort 1 $c_br3 5
#connect broadcasr to dummy port on c_br3
python ovxctl.py -n connectHost 1 $c_br3 5 $broadcast

################################################################
#Start network
################################################################

echo "Now starting network..."
python ovxctl.py -n startNetwork 1
