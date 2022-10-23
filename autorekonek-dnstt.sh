#!/bin/bash
#dnstt (Wegare)
route="$(route | grep -i 1.1.1.1 | head -n1 | awk '{print $2}')" 
route2="$(route | grep -i 10.0.0.2 | head -n1 | awk '{print $2}')" 
route3="$(netstat -plantu | grep -i xray | grep -i 10808 | grep -i listen)" 
route4="$(netstat -plantu | grep dns-client)" 

echo $route
	if [[ -z $route2 ]]; then
		   printf '\n' | dnstt
           exit
    elif [[ -z $route3 ]]; then
           printf '\n' | dnstt
           exit
    elif [[ -z $route ]]; then
           printf '\n' | dnstt
           exit
    elif [[ -z $route4 ]]; then
           printf '\n' | dnstt
           exit
	fi
