# lime-scripts
Scripts used to configure lime
The primary scripts used to configure and run LIME and an OpenVirtex virtual network 
are the scripts runTestNetwork.sh and all of the scripts that are called by this script.
All of these are Bash scripts for now.

OpenVirtex can be cloned from its git repo at: https://github.com/opennetworkinglab/OpenVirteX
and run by executing the script ovx.sh in the scripts/ folder of their directory.

In order to run Lime, an OF controller must be running at the ip address that Lime is configured to contact.
This is currently hardcoded to 192.168.1.3 (sorry), but can be changed by editing the file 
org.flowvisor.slicer.OriginalSwitch and changing the "hostname" variable at line ~161 to the desired IP address.
I plan to make this dynamically configurable in the future.

OVX must also be running before the runTestNetwork.sh script is run, else the virtual network cannot be created.
