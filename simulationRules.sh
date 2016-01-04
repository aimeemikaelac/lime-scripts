#!/bin/bash

curl -d '{"switch": "00:00:ee:79:fd:4a:92:4f", "name":"mod-1", "priority":"100", "ingress-port":"11", "active":"true", "actions":"output=12"}' http://192.168.1.3:8080/wm/staticflowentrypusher/json
echo ""
curl -d '{"switch": "00:00:ee:79:fd:4a:92:4f", "name":"mod-2", "priority":"100", "ingress-port":"12", "active":"true", "actions":"output=11"}' http://192.168.1.3:8080/wm/staticflowentrypusher/json
echo ""
#curl -d '{"switch": "00:00:ee:79:fd:4a:92:4f", "name":"mod-3", "priority":"100", "ingress-port":"12", "active":"true", "actions":"set-vlan-id=1,output=5"}' http://192.168.1.3:8080/wm/staticflowentrypusher/json
echo ""
#curl -d '{"switch": "00:00:ee:79:fd:4a:92:4f", "name":"mod-4", "priority":"100", "ingress-port":"5","vlan-id":"1", "active":"true", "actions":"strip-vlan,output=12"}' http://192.168.1.3:8080/wm/staticflowentrypusher/json
echo ""
#curl -d '{"switch": "00:00:d2:a0:2a:32:2c:48", "name":"mod-5", "priority":"100", "ingress-port":"4","vlan-id":"1", "active":"true", "actions":"strip-vlan,output=9"}' http://192.168.1.3:8080/wm/staticflowentrypusher/json
echo ""
#curl -d '{"switch": "00:00:d2:a0:2a:32:2c:48", "name":"mod-3", "priority":"100", "ingress-port":"9", "active":"true", "actions":"set-vlan-id=1,output=4"}' http://192.168.1.3:8080/wm/staticflowentrypusher/json
