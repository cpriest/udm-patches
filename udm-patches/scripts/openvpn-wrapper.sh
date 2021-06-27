#!/bin/sh

args="$*";

PROFILE="$(echo \"$args\" | grep -oE 'openvpn-[0-9]+')";

UDM_DIR="/mnt/data/udm-patches"
PROF_DIR="${UDM_DIR}/${PROFILE}/"
LOG_FILE="/tmp/openvpn-orig.log";

{
	echo "********* OpenVPN Wrapper Intercept *********";
	echo "UDM Called: $0 $*";
	echo "   PROFILE_NUM=${PROFILE}, PROF_DIR=${PROF_DIR}"; 
	echo "********* OpenVPN Wrapper Intercept *********";
} >> "$LOG_FILE";

# If there is an openvpn-N profile directory, use that configuration instead
if [[ -e "$PROF_DIR" ]]; then
	mkdir -p /run/${PROFILE}/.disabled;
	mv /run/${PROFILE}/* /run/${PROFILE}/.disabled;
	cp ${PROF_DIR}/*.conf /run/${PROFILE}/${PROFILE}.conf;

	exec /usr/sbin/openvpn-orig --config /run/${PROFILE}/${PROFILE}.conf 2>&1 >> "${LOG_FILE}";
else
	exec /usr/sbin/openvpn-orig $*
fi;
