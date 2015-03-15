#!/bin/bash

original_ovx_switch="00:a4:23:05:00:00:00:01"
original_ovx_switch_2="00:a4:23:05:00:00:00:02"
original_ovx_switch_3="00:a4:23:05:00:00:00:03"
clone_ovx_switch="00:a4:23:05:00:00:00:04"
clone_ovx_switch_2="00:a4:23:05:00:00:00:05"
clone_ovx_switch_3="00:a4:23:05:00:00:00:06"

int_1_mac="52:54:00:aa:52:b8"
int_2_mac="52:54:00:49:a5:72"
int_3_mac="52:54:00:f5:e0:11"
int_4_mac="52:54:00:43:cb:e3"
int_5_mac="52:54:00:59:80:71"

original_1_string="{
\"%original_ovx_switch\":
	{
		\"ports\":
			{
				\"1\":{\"type\":\"GHOST\"},
				\"2\":{\"type\":\"SW_CONNECTED\"},
				\"3\":{\"type\":\"H_CONNECTED\",\"mac\":\"$int_1_mac\"},
				\"4\":{\"type\":\"H_CONNECTED\",\"mac\":\"$int_2_mac\"},
				\"5\":{\"type\":\"H_CONNECTED\",\"mac\":\"$int_3_mac\"},
				\"6\":{\"type\":\"DUMMY\"}
			}
	}
}"

original_2_string="{
\"%original_ovx_switch\":
	{
		\"ports\":
			{
				\"1\":{\"type\":\"GHOST\"},
				\"2\":{\"type\":\"SW_CONNECTED\"},
				\"3\":{\"type\":\"SW_CONNECTED\"},
				\"4\":{\"type\":\"DUMMY\"}
			}
	}
}"

original_3_string="{
\"%original_ovx_switch\":
	{
		\"ports\":
			{
				\"1\":{\"type\":\"GHOST\"},
				\"2\":{\"type\":\"SW_CONNECTED\"},
				\"3\":{\"type\":\"H_CONNECTED\",\"mac\":\"$int_4_mac\"},
				\"4\":{\"type\":\"H_CONNECTED\",\"mac\":\"$int_5_mac\"},
				\"5\":{\"type\":\"DUMMY\"}
			}
	}
}"


clone_1_string="{
\"%original_ovx_switch\":
	{
		\"ports\":
			{
				\"1\":{\"type\":\"GHOST\"},
				\"2\":{\"type\":\"SW_CONNECTED\"},
				\"3\":{\"type\":\"EMPTY\"},
				\"4\":{\"type\":\"EMPTY\"},
				\"5\":{\"type\":\"EMPTY\"},
				\"6\":{\"type\":\"DUMMY\"}
			}
	}
}"

clone_2_string="{
\"%original_ovx_switch\":
	{
		\"ports\":
			{
				\"1\":{\"type\":\"GHOST\"},
				\"2\":{\"type\":\"SW_CONNECTED\"},
				\"3\":{\"type\":\"SW_CONNECTED\"},
				\"4\":{\"type\":\"DUMMY\"}
			}
	}
}"

clone_3_string="{
\"%original_ovx_switch\":
	{
		\"ports\":
			{
				\"1\":{\"type\":\"GHOST\"},
				\"2\":{\"type\":\"SW_CONNECTED\"},
				\"3\":{\"type\":\"EMPTY\"},
				\"4\":{\"type\":\"EMPTY\"},
				\"5\":{\"type\":\"DUMMY\"}
			}
	}
}"


echo $original_1_string
echo $original_2_string
echo $original_3_string

echo $clone_1_string
echo $clone_2_string
echo $clone_3_string

curl -d "$original_1_string" http://192.168.1.1:9000/config
curl -d "$original_2_string" http://192.168.1.1:9000/config
curl -d "$original_3_string" http://192.168.1.1:9000/config

curl -d "$clone_1_string" http://192.168.1.1:9000/config
curl -d "$clone_2_string" http://192.168.1.1:9000/config
curl -d "$clone_3_string" http://192.168.1.1:9000/config

echo ""
