#!/bin/bash

#python ovxctl.py -n disconnectHost 1 3
#python ovxctl.py -n disconnectHost 1 9
python ovxctl.py -n startPort 1 00:a4:23:05:00:00:00:01 4
python ovxctl.py -n startPort 1 00:a4:23:05:00:00:00:0224
#python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:02 4 52:54:00:f5:e0:11
#python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:01 4 ce:5a:b9:7c:87:b6
