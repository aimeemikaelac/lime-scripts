#!/bin/bash

#python ovxctl.py -n disconnectHost 1 5
#python ovxctl.py -n disconnectHost 1 11
python ovxctl.py -n startPort 1 00:a4:23:05:00:00:00:01 6
python ovxctl.py -n startPort 1 00:a4:23:05:00:00:00:02 6
#python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:02 6 52:54:00:59:80:71
#python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:01 6 ce:5a:b9:7c:87:b8
