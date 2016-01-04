#!/bin/bash

python ovxctl.py -n disconnectHost 1 1
python ovxctl.py -n disconnectHost 1 7
python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:02 2 52:54:00:aa:52:b8
