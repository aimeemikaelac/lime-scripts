#!/bin/sh
python ovxctl.py -n createNetwork tcp:172.16.1.1:6633 10.0.0.0 16  #LIME address

python ovxctl.py -n createSwitch 1 00:00:72:75:3c:c9:ff:40
python ovxctl.py -n createSwitch 1 00:00:da:c6:44:7a:92:41
#python ovxctl.py -n createSwitch 1 00:00:00:00:00:00:03:00

python ovxctl.py -n createPort 1 00:00:72:75:3c:c9:ff:40 4 # this should create port 1 for vswitch 00:a4:23:05:00:00:00:03
python ovxctl.py -n createPort 1 00:00:72:75:3c:c9:ff:40 5
python ovxctl.py -n createPort 1 00:00:72:75:3c:c9:ff:40 6 # this should create port 3 for vswitch 00:a4:23:05:00:00:00:03, we don't need this for now since we wont have host to connect to it
#python ovxctl.py -n createPort 1 00:00:00:00:00:00:01:00 3 # this should create port 3 for vswitch 00:a4:23:05:00:00:00:03

python ovxctl.py -n createPort 1 00:00:da:c6:44:7a:92:41 4
python ovxctl.py -n createPort 1 00:00:da:c6:44:7a:92:41 5
python ovxctl.py -n createPort 1 00:00:da:c6:44:7a:92:41 6

#python ovxctl.py -n createPort 1 00:00:00:00:00:00:03:00 2 # this should create port 1 for vswitch 00:a4:23:05:00:00:00:03
#python ovxctl.py -n createPort 1 00:00:00:00:00:00:03:00 3 # this should create port 2 for vswitch 00:a4:23:05:00:00:00:03, we don't need this for now since we wont have host to connect to it
#python ovxctl.py -n createPort 1 00:00:00:00:00:00:03:00 3 # this should create port 3 for vswitch 00:a4:23:05:00:00:00:03


python ovxctl.py -n connectLink 1 00:a4:23:05:00:00:00:01 3 00:a4:23:05:00:00:00:02 3 spf 1


python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:01 1 52:54:00:0b:63:04  #connect h1_s1 to this switch
python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:01 2 52:54:00:31:4f:9e  # connecting h1_s2 to this vswitch

echo "Now starting newtork..."
python ovxctl.py -n startNetwork 1
