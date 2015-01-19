#!/bin/bash

original_ovx_switch="00:a4:23:05:00:00:00:01"
clone_ovx_switch="00:a4:23:05:00:00:00:02"

original_format_string="{\n\"%s\":\n{\"ports\":\n{\"1\":\"GHOST\",\n\"2\":\"H_CONNECTED\",\n\"3\":\"H_CONNECTED\"\n}\n}\n}"

clone_format_string="{\n\"%s\":\n{\"ports\":\n{\"1\":\"GHOST\",\n\"2\":\"EMPTY\",\n\"3\":\"EMPTY\"\n},\n\"original\":\"$original_ovx_switch\"}\n}"

original_data=$(printf "$original_format_string" "$original_ovx_switch")

clone_data=$(printf "$clone_format_string" "$clone_ovx_switch")

echo $original_data

echo $clone_data

curl -d "$original_data" http://192.168.1.1:9000/config

curl -d "$clone_data" http://192.168.1.1:9000/config

echo ""
