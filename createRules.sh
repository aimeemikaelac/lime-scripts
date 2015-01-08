#!/bin/bash

curl -d '{"switch": "00:a4:23:05:00:00:00:01", "name":"mod-2", "priority":"100", "ingress-port":"3", "active":"true", "actions":"output=2"}' http://192.168.1.3:8080/wm/staticflowentrypusher/json
echo ""
curl -d '{"switch": "00:a4:23:05:00:00:00:01", "name":"mod-1", "priority":"100", "ingress-port":"2", "active":"true", "actions":"output=3"}' http://192.168.1.3:8080/wm/staticflowentrypusher/json
echo ""
