#!/bin/sh

args="$*";

PROFILE="$(echo \"$args\" | grep -oE 'openvpn-[0-9]+')";

UDM_DIR="/mnt/data/udm-patches"
PROF_DIR="${UDM_DIR}/${PROFILE}/"

# If there is an openvpn-N profile directory, use that configuration instead
if [[ -e "$PROF_DIR" ]]; then
	mkdir -p /run/${PROFILE}/.disabled;
	mv /run/${PROFILE}/* /run/${PROFILE}/.disabled;
	cp ${PROF_DIR}/*.conf /run/${PROFILE}/${PROFILE}.conf;

	exec /usr/sbin/openvpn-orig --config /run/${PROFILE}/${PROFILE}.conf >& /tmp/openvpn-orig.log
else
	exec /usr/sbin/openvpn-orig $*
fi;
