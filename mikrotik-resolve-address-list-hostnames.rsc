
# This script requires "read" and "write" policies,
# and "test" policy for ":resolve".

# When run, it searches for all the address-lists in the firewall.
# If the list-name ends with the sufix ("_names"), the list-comment
# is resolved as a hostname (dns) and the resulting IP is applied
# to the list-value. Resolve errors are ignored, all adddress-lists
# are evaluated.

# This is used to create firewall rules to servers hostnames when
# their IP is changing or unknown. As example, you can filter the
# allowed NTP servers for the network.

# define variables
:local list
:local listlen
:local listfind
:local comment
:local newip
:local oldip

[/log info "resolving list start ..."]

:foreach i in=[/ip firewall address-list find] do={
  :set list [/ip firewall address-list get $i list]
  :set listlen [:len $list]
  :set listfind [:find $list "_names"]
  :if (($listlen >= 6) && ($listfind = ($listlen - 6))) do={
    :set comment [/ip firewall address-list get $i comment]
    :set oldip [/ip firewall address-list get $i address]
    [/log info "resolving list ($list) hostname($comment) current($oldip)"]
    :do {
      :set newip [:resolve "$comment"]
      [/ip firewall address-list set $i address=$newip]
      [/log info "resolved list ($list) hostname($comment) ip($newip)"]
    } on-error={ 
      [/log error "resolving list ($list) hostname($comment) ip($newip) failed"]
    }
  }
}

[/log info "resolving list ... end"]