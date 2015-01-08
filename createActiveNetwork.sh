#!/bin/sh
python ovxctl.py -n createNetwork tcp:172.16.1.1:6633 10.0.0.0 16  #LIME address

python ovxctl.py -n createSwitch 1 00:00:00:00:00:00:02:00,00:00:00:00:00:00:04:00 # this will return vswitch 00:a4:23:05:00:00:00:01
python ovxctl.py -n createSwitch 1 00:00:00:00:00:00:08:00 # this will return vswitch 00:a4:23:05:00:00:00:02
python ovxctl.py -n createSwitch 1 00:00:00:00:00:00:05:00,00:00:00:00:00:00:0a:00,00:00:00:00:00:00:0b:00 # this will return vswitch 00:a4:23:05:00:00:00:03

python ovxctl.py -n createPort 1 00:00:00:00:00:00:04:00 1 # this should create port 1 for vswitch 00:a4:23:05:00:00:00:01
python ovxctl.py -n createPort 1 00:00:00:00:00:00:02:00 2 # this should create port 2 for vswitch 00:a4:23:05:00:00:00:01

python ovxctl.py -n createPort 1 00:00:00:00:00:00:08:00 1 # this should create port 1 for vswitch 00:a4:23:05:00:00:00:02
python ovxctl.py -n createPort 1 00:00:00:00:00:00:08:00 2 # this should create port 2 for vswitch 00:a4:23:05:00:00:00:02
python ovxctl.py -n createPort 1 00:00:00:00:00:00:08:00 3 # this should create port 3 for vswitch 00:a4:23:05:00:00:00:02
#python ovxctl.py -n createPort 1 00:00:00:00:00:00:08:00 3 # this should create port 4 for vswitch 00:a4:23:05:00:00:00:02

python ovxctl.py -n createPort 1 00:00:00:00:00:00:0a:00 1 # this should create port 1 for vswitch 00:a4:23:05:00:00:00:03
python ovxctl.py -n createPort 1 00:00:00:00:00:00:0a:00 2 # this should create port 2 for vswitch 00:a4:23:05:00:00:00:03
python ovxctl.py -n createPort 1 00:00:00:00:00:00:05:00 3 # this should create port 3 for vswitch 00:a4:23:05:00:00:00:03

python ovxctl.py -n connectLink 1 00:a4:23:05:00:00:00:01 1 00:a4:23:05:00:00:00:02 3 spf 1
python ovxctl.py -n connectLink 1 00:a4:23:05:00:00:00:01 2 00:a4:23:05:00:00:00:03 3 spf 1

python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:02 1 00:00:00:00:08:01  # connecting h1_s8 to this vswitch
python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:02 2 00:00:00:00:08:02  # connecting h2_s8 to this vswitch

echo "Now starting newtork..."
python ovxctl.py -n startNetwork 1
