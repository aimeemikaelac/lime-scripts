#!/bin/bash

#curl -d '{"switch": "00:00:ee:79:fd:4a:92:4f", "name":"mod-1", "priority":"100", "ingress-port":"11", "active":"true", "actions":"output=12"}' http://192.168.1.3:8080/wm/staticflowentrypusher/json
#echo ""
#curl -d '{"switch": "00:00:ee:79:fd:4a:92:4f", "name":"mod-2", "priority":"100", "ingress-port":"12", "active":"true", "actions":"output=11"}' http://192.168.1.3:8080/wm/staticflowentrypusher/json
#echo ""
curl -d '{"switch": "00:a4:23:05:00:00:00:01", "name":"mod-3", "priority":"100", "in_port":"3", "eth_type":"0x0800", "active":"true", "actions":"set_mpls_label=1,output=1"}' http://192.168.1.3:8080/wm/staticflowpusher/json
echo ""
curl -d '{"switch": "00:a4:23:05:00:00:00:01", "name":"mod-4", "priority":"100", "in_port":"1","eth_type":"0x0847","mpls_label":"1", "active":"true", "actions":"pop_mpls=1,output=3"}' http://192.168.1.3:8080/wm/staticflowpusher/json
echo ""
curl -d '{"switch": "00:a4:23:05:00:00:00:02", "name":"mod-5", "priority":"100", "in_port":"2", "eth_type":"0x0800","active":"true", "actions":"set_mpls_label=1,output=1"}' http://192.168.1.3:8080/wm/staticflowpusher/json
echo ""
curl -d '{"switch": "00:a4:23:05:00:00:00:02", "name":"mod-6", "priority":"100", "in_port":"1","eth_type":"0x0847","mpls_label":"1", "active":"true", "actions":"pop_mpls=1,output=1"}' http://192.168.1.3:8080/wm/staticflowpusher/json
echo ""
