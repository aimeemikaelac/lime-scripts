#!/bin/bash

original_ovx_switch="00:a4:23:05:00:00:00:01"
clone_ovx_switch="00:a4:23:05:00:00:00:02"

original_format_string="{\n\"%s\":\n{\"ports\":\n{\"1\":{\"type\":\"GHOST\"},\n\"2\":{\"type\":\"H_CONNECTED\",\"mac\":\"52:54:00:aa:52:b8\"},\n\"3\":{\"type\":\"H_CONNECTED\",\"mac\":\"52:54:00:49:a5:72\"}\n,\n\"4\":{\"type\":\"H_CONNECTED\",\"mac\":\"52:54:00:f5:e0:11\"},\n\"5\":{\"type\":\"H_CONNECTED\",\"mac\":\"52:54:00:43:cb:e3\"},\n\"6\":{\"type\":\"H_CONNECTED\",\"mac\":\"52:54:00:59:80:71\"},\n\"7\":{\"type\":\"DUMMY\"}\n}\n}\n}"

clone_format_string="{\n\"%s\":\n{\"ports\":\n{\"1\":{\"type\":\"GHOST\"},\n\"2\":{\"type\":\"EMPTY\"},\n\"3\":{\"type\":\"EMPTY\"},\n\"4\":{\"type\":\"EMPTY\"},\n\"5\":{\"type\":\"EMPTY\"},\n\"6\":{\"type\":\"EMPTY\"},\n\"7\":{\"type\":\"DUMMY\"}\n},\n\"original\":\"$original_ovx_switch\"}\n}"

original_data=$(printf "$original_format_string" "$original_ovx_switch")

clone_data=$(printf "$clone_format_string" "$clone_ovx_switch")

echo $original_data

echo $clone_data

curl -d "$original_data" http://192.168.1.1:9000/config

curl -d "$clone_data" http://192.168.1.1:9000/config

echo ""
