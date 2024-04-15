# mikrotik-resolve-address-list-hostnames

Script to automatically resolve hostnames in firewall address lists for Mikrotik RouterOS.

# Whats new?

This script is based on the examples available on Mikrotik website and forums online. The main difference is the use of a sufix, instead of a prefix. I prefer sufix for redeability on my firewall rules.

# About

This script requires "read" and "write" policies, and "test" policy for ":resolve".

When run, it searches for all the address-lists in the firewall. If the list-name ends with the sufix ("_names"), the list-comment is resolved as a hostname (dns) and the resulting IP is applied to the list-value. Resolve errors are ignored, all adddress-lists are evaluated.

This is used to create firewall rules to servers hostnames when their IP is changing or unknown. As example, you can filter the allowed NTP servers for the network.

# Version

Used on Mikrotik RouterOS 13.5.

# Use

Add the script in "/system script add", add periodic runs in "/system scheduler add". Use terminal or  web interface. Logs are printed when run.