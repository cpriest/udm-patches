#!/bin/sh

# Setup/Teardown masqeurade for the tunnel interface
if [[ "$1" = "up" ]]; then
	iptables -t nat -I POSTROUTING -o tun${2} -j MASQUERADE
elif [[ "$1" = "down" ]]; then
	iptables -t nat -D POSTROUTING -o tun${2} -j MASQUERADE
fi;

# Notify ubios as per its usual method
ubios-udapi-client -n INTERNAL -r /vpn/openvpn/peers/${2} '{ "action": "'${1}'" }'
