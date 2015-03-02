#!/bin/bash

#curl -d '{"switch": "00:00:ee:79:fd:4a:92:4f", "name":"mod-1", "priority":"100", "ingress-port":"11", "active":"true", "actions":"output=12"}' http://192.168.1.3:8080/wm/staticflowentrypusher/json
#echo ""
#curl -d '{"switch": "00:00:ee:79:fd:4a:92:4f", "name":"mod-2", "priority":"100", "ingress-port":"12", "active":"true", "actions":"output=11"}' http://192.168.1.3:8080/wm/staticflowentrypusher/json
#echo ""
curl -d '{"switch": "00:a4:23:05:00:00:00:01", "name":"mod-3", "priority":"100", "ingress-port":"3", "active":"true", "actions":"output=1"}' http://192.168.1.3:8080/wm/staticflowentrypusher/json
echo ""
curl -d '{"switch": "00:a4:23:05:00:00:00:01", "name":"mod-4", "priority":"100", "ingress-port":"1", "active":"true", "actions":"output=3"}' http://192.168.1.3:8080/wm/staticflowentrypusher/json
echo ""
curl -d '{"switch": "00:a4:23:05:00:00:00:02", "name":"mod-5", "priority":"100", "ingress-port":"3", "active":"true", "actions":"output=1"}' http://192.168.1.3:8080/wm/staticflowentrypusher/json
echo ""
curl -d '{"switch": "00:a4:23:05:00:00:00:02", "name":"mod-6", "priority":"100", "ingress-port":"1", "active":"true", "actions":"output=3"}' http://192.168.1.3:8080/wm/staticflowentrypusher/json
echo ""
curl -d '{"switch": "00:a4:23:05:00:00:00:01", "name":"mod-7", "priority":"100", "ingress-port":"2", "active":"true", "actions":"output=4"}' http://192.168.1.3:8080/wm/staticflowentrypusher/json
echo ""
curl -d '{"switch": "00:a4:23:05:00:00:00:01", "name":"mod-8", "priority":"100", "ingress-port":"4", "active":"true", "actions":"output=2"}' http://192.168.1.3:8080/wm/staticflowentrypusher/json
echo ""
curl -d '{"switch": "00:a4:23:05:00:00:00:02", "name":"mod-9", "priority":"100", "ingress-port":"2", "active":"true", "actions":"output=4"}' http://192.168.1.3:8080/wm/staticflowentrypusher/json
echo ""
curl -d '{"switch": "00:a4:23:05:00:00:00:02", "name":"mod-10", "priority":"100", "ingress-port":"4", "active":"true", "actions":"output=2"}' http://192.168.1.3:8080/wm/staticflowentrypusher/json
echo ""
