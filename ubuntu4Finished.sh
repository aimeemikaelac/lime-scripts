#!/bin/bash

python ovxctl.py -n disconnectHost 1 4
python ovxctl.py -n disconnectHost 1 10
python ovxctl.py -n connectHost 1 00:a4:23:05:00:00:00:02 5 52:54:00:43:cb:e3
