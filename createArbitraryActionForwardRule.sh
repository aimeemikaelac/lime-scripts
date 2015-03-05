#!/bin/bash

if [ -z "$1" ];
then 
	echo "Need source port number";
	exit 1;
fi

if [ -z "$2" ];
then 
	echo "Need destination string";
	exit 1;
fi

if [ -z "$3" ];
then 
	echo "Need dpid";
	exit 1;
fi
curl -d "{\"switch\": \"$3\", \"name\":\"mod-$1_to_$2\", \"priority\":\"100\", \"ingress-port\":\"$1\", \"active\":\"true\", \"actions\":\"$2\"}" http://192.168.1.3:8080/wm/staticflowentrypusher/json
echo ""
echo "Wrote rule that forawrds ports $1 to $2 on switch $3"
#curl -d '{"switch": "00:a4:23:05:00:00:00:01", "name":"mod-1", "priority":"100", "ingress-port":"2", "active":"true", "actions":"output=3"}' http://192.168.1.3:8080/wm/staticflowentrypusher/json
#echo ""
#curl -d '{"switch": "00:a4:23:05:00:00:00:01", "name":"mod-3", "priority":"100", "ingress-port":"1", "vlan-id":"20", "active":"true", "actions":"strip-vlan,output=2"}' http://192.168.1.3:8080/wm/staticflowentrypusher/json
#echo ""
#curl -d '{"switch": "00:a4:23:05:00:00:00:01", "name":"mod-4", "priority":"100", "ingress-port":"2", "active":"true", "actions":"set-vlan-id=20,output=1"}' http://192.168.1.3:8080/wm/staticflowentrypusher/json
#echo ""
