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


ubuntu_int1_interface="ubuntu1.tap"
ubuntu_int1_port=$(ssh $1 sudo ovs-vsctl get Interface $ubuntu_int1_interface ofport)

ubuntu_int2_interface="ubuntu2.tap"
ubuntu_int2_port=$(ssh $1 sudo ovs-vsctl get Interface $ubuntu_int2_interface ofport)



ubuntu_int1_port_clone=$(ssh $2 sudo ovs-vsctl get Interface $ubuntu_int1_interface ofport)

ubuntu_int2_port_clone=$(ssh $2 sudo ovs-vsctl get Interface $ubuntu_int2_interface ofport)



ubuntu_int3_interface="ubuntu3.tap"
ubuntu_int3_port=$(ssh $1 sudo ovs-vsctl get Interface $ubuntu_int3_interface ofport)

ubuntu_int4_interface="ubuntu4.tap"
ubuntu_int4_port=$(ssh $1 sudo ovs-vsctl get Interface $ubuntu_int4_interface ofport)

ubuntu_int5_interface="ubuntu5.tap"
ubuntu_int5_port=$(ssh $1 sudo ovs-vsctl get Interface $ubuntu_int5_interface ofport)


ubuntu_int3_port_clone=$(ssh $2 sudo ovs-vsctl get Interface $ubuntu_int3_interface ofport)

ubuntu_int4_port_clone=$(ssh $2 sudo ovs-vsctl get Interface $ubuntu_int4_interface ofport)

ubuntu_int5_port_clone=$(ssh $2 sudo ovs-vsctl get Interface $ubuntu_int5_interface ofport)


gre_2_interface="r720_2_to_3.gre"

gre_3_interface="r720_3_to_2.gre"

br2_interface="br2.gre"
br3_interface="br3.gre"


gre_r720_2=$(ssh $1 sudo ovs-vsctl get Interface $gre_2_interface ofport)

gre_r720_3=$(ssh $2 sudo ovs-vsctl get Interface $gre_3_interface ofport)

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

dummy1_2=$(ssh $1 sudo ovs-vsctl get Interface dummy2.tap ofport)
dummy2_2=$(ssh $2 sudo ovs-vsctl get Interface dummy2.tap ofport)

dummy1_3=$(ssh $1 sudo ovs-vsctl get Interface dummy3.tap ofport)
dummy2_3=$(ssh $1 sudo ovs-vsctl get Interface dummy3.tap ofport)

original_br1=$(ssh $1 sudo ovs-ofctl show br1 | grep -oP "dpid:.+" | sed 's/dpid://' | sed 's/\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3:\4:\5:\6:\7:\8/')
original_br2=$(ssh $1 sudo ovs-ofctl show br2 | grep -oP "dpid:.+" | sed 's/dpid://' | sed 's/\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3:\4:\5:\6:\7:\8/')
original_br2=$(ssh $1 sudo ovs-ofctl show br2 | grep -oP "dpid:.+" | sed 's/dpid://' | sed 's/\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3:\4:\5:\6:\7:\8/')
clone_br1=$(ssh $2 sudo ovs-ofctl show br1 | grep -oP "dpid:.+" | sed 's/dpid://' | sed 's/\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3:\4:\5:\6:\7:\8/')
clone_br2=$(ssh $2 sudo ovs-ofctl show br2 | grep -oP "dpid:.+" | sed 's/dpid://' | sed 's/\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3:\4:\5:\6:\7:\8/')
clone_br3=$(ssh $2 sudo ovs-ofctl show br3 | grep -oP "dpid:.+" | sed 's/dpid://' | sed 's/\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3:\4:\5:\6:\7:\8/')

################################################################
#Print gathered information
################################################################
echo "ubuntu-int1 OVS OF port: $ubuntu_int1_port"
echo "ubuntu-int2 KVM OF port: $ubuntu_int2_port"
echo "ubuntu-int3 KVM OF port: $ubuntu_int3_port"
echo "ubuntu-int4 KVM OF port: $ubuntu_int4_port"
echo "ubuntu-int5 KVM OF port: $ubuntu_int5_port"
echo "ubuntu-int1 clone OVS OF port: $ubuntu_int1_port_clone"
echo "ubuntu-int2 clone OVS OF port: $ubuntu_int2_port_clone"
echo "ubuntu-int3 clone OVS OF port: $ubuntu_int3_port_clone"
echo "ubuntu-int4 clone OVS OF port: $ubuntu_int4_port_clone"
echo "ubuntu-int5 clone OVS OF port: $ubuntu_int5_port_clone"
echo "br1 gre tunnel of r720-2 to r720-3 OF port on r720-2: $gre_r720_2"
echo "br2 gre tunnel of r720-2 to r720-3 OF port on r720-2: $br2_gre_r720_2"
echo "br3 gre tunnel of r720-2 to r720-3 OF port on r720-2: $br2_gre_r720_3"
echo "br1 gre tunnel of r720-3 to r720-2 OF port on r720-3: $gre_r720_3"
echo "br2 gre tunnel of r720-3 to r720-2 OF port on r720-3: $br2_gre_r720_3"
echo "br3 gre tunnel of r720-3 to r720-2 OF port on r720-3: $br3_gre_r720_3"
echo "original br1 dpid: $original_br1"
echo "original br2 dpid: $original_br2"
echo "original br3 dpid: $original_br3"
echo "clone br1 dpid: $clone_br1"
echo "clone br2 dpid: $clone_br2"
echo "clone br3 dpid: $clone_br3"
echo "original br1 dummy port: $dummy1"
echo "original br2 dummy port: $dummy1_2"
echo "original br3 dummy port: $dummy1_3"
echo "clone br1 dummy port: $dummy2"
echo "clone br2 dummy port: $dummy2_2"
echo "clone br3 dummy port: $dummy2_3"

python ovxctl.py -n createNetwork tcp:192.168.1.1:6633 192.168.3.1 24  #LIME address

################################################################
#Create OVX switches
################################################################

#create first physical to ovx switch mapping. returns 00:a4:23:05:00:00:00:01 as first ovx switch dpid
#00:a4:23:05:00:00:00:01 -> switch br1
python ovxctl.py -n createSwitch 1 $original_br1
br1="00:a4:23:05:00:00:00:01"
#00:a4:23:05:00:00:00:02 -> switch br2
python ovxctl.py -n createSwitch 1 $original_br2
br2="00:a4:23:05:00:00:00:02"
#00:a4:23:05:00:00:00:03 -> switch br3
python ovxctl.py -n createSwitch 1 $original_br3
br3="00:a4:23:05:00:00:00:03"

#00:a4:23:05:00:00:00:04
python ovxctl.py -n createSwitch 1 $clone_br1
c_br1="00:a4:23:05:00:00:00:04"
#00:a4:23:05:00:00:00:05
python ovxctl.py -n createSwitch 1 $clone_br2
c_br2="00:a4:23:05:00:00:00:05"
#00:a4:23:05:00:00:00:06
python ovxctl.py -n createSwitch 1 $clone_br3
c_br3="00:a4:23:05:00:00:00:06"

##############################################################
#Clone switches
##############################################################
#creates r720-3 gre tunnel port on port 1 of vswitch c_br1
python ovxctl.py -n createPort 1 $clone_br1 $gre_r720_3
#same on c_br2
python ovxctl.py -n createPort 1 $clone_br2 $br2_gre_r720_3
#same on c_br3
python ovxctl.py -n createPort 1 $clone_br2 $br3_gre_r720_3

#create port 2 on c_br1 - the connection to c_br2
python ovxctl.py -n createPort 1 $clone_br1 $br1_2_r3
#create port 3 on c_br1 - ubuntu-int1 clone
python ovxctl.py -n createPort 1 $clone_br1 $ubuntu_int1_port_clone
#create port 4 on c_br1 - ubuntu-int2 clone
python ovxctl.py -n createPort 1 $clone_br1 $ubuntu_int2_port_clone
#create port 5 on c_br1 - ubuntu-int3 clone
python ovxctl.py -n createPort 1 $clone_br1 $ubuntu_int3_port_clone
#create port 6 on c_br1 - dummy
python ovxctl.py -n createPort 1 $clone_br1 $dummy2


#create port 2 on c_br2 - the connection to c_br1
python ovxctl.py -n createPort 1 $clone_br2 $br2_1_r3
#create port 3 on c_br2 - the connection to c_br3
python ovxctl.py -n createPort 1 $clone_br2 $br2_3_r3
#create port 4 on c_br3 - dummy
python ovxctl.py -n createPort 1 $clone_br2 $dummy2_2

#create port 2 on c_br3 - the connection to c_br2
python ovxctl.py -n createPort 1 $clone_br3 $br3_2_r3
#create port 3 on c_br3 - ubuntu-int4 clone
python ovxctl.py -n createPort 1 $clone_br3 $ubuntu_int4_port_clone
#create port 4 on c_br3 - ubuntu-int5 clone
python ovxctl.py -n createPort 1 $clone_br5 $ubuntu_int5_port_clone
#create port 5 on c_br3 - dummy
python ovxctl.py -n createPort 1 $clone_br5 $dummy2_3
#TEST: create another  port on a physical port
#python ovxctl.py -n createPort 1 $clone_switch $gre_r720_3
################################################################
#Original switches
################################################################
#create r720-2 gre tunnel on port 1 of vswitch br1
python ovxctl.py -n createPort 1 $original_br1 $gre_r720_2
#same in br2
python ovxctl.py -n createPort 1 $original_br2 $br2_gre_r720_2
#same in br3
python ovxctl.py -n createPort 1 $original_br3 $br3_gre_r720_2

#create port 2 on br1 - the connection to br2
python ovxctl.py -n createPort 1 $original_br1 $br1_2_r2
#create port 3 on br1 - ubuntu-int1
python ovxctl.py -n createPort 1 $original_br1 $ubuntu_int1_port
#create port 4 on br1 - ubuntu-int2
python ovxctl.py -n createPort 1 $original_br1 $ubuntu_int2_port
#create port 5 on br1 - ubuntu-int3
python ovxctl.py -n createPort 1 $original_br1 $ubuntu_int3_port
#create port 6 on br1 - dummy
python ovxctl.py -n createPort 1 $original_br1 $dummy

#create port 2 on br2 - the connection to br1
python ovxctl.py -n createPort 1 $original_br2 $br2_1_r2
#create port 3 on br2 - the connection to br3
python ovxctl.py -n createPort 1 $original_br2 $br2_3_r2
#create port 4 on br3 - dummy
python ovxctl.py -n createPort 1 $original_br2 $dummy2

#create port 2 on br3 - the connection to br2
python ovxctl.py -n createPort 1 $original_br3 $br3_2_r2
#create port 3 on br3 - ubuntu-int4
python ovxctl.py -n createPort 1 $original_br3 $ubuntu_int4_port
#create port 4 on br3 - ubuntu-int5
python ovxctl.py -n createPort 1 $original_br3 $ubuntu_int5_port
#create port 5 on br3 - dummy
python ovxctl.py -n createPort 1 $original_br3 $dummy3
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
