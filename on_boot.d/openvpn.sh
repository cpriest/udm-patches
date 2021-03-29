#!/bin/sh

PKG_DIR=/mnt/data/udm-patches
BIN_DIR=/usr/sbin

# Per Github Issue #7, it appears doing this on boot without a delay
# can cause some issues, adding in a one minute sleep delay before this
# finishes execution
sleep 60;

# Rename the openvpn binary and install our wrapper
# The wrapper will be called by UDM to start an openvpn connection
if [[ ! -e ${BIN_DIR}/openvpn-orig ]]; then
	mv ${BIN_DIR}/openvpn ${BIN_DIR}/openvpn-orig
	ln -s ${PKG_DIR}/scripts/openvpn-wrapper.sh ${BIN_DIR}/openvpn
fi;

# This script is run after native openvpn configs have already launched, this
# kills existing connections which the UDM will re-launch, but now with our 
# wrapper in place
for x in 1 2 3 4 5 6 7 8 9 10; do
	if [[ -e /run/openvpn-$x/peer.pid ]]; then
		kill `cat /run/openvpn-$x/peer.pid`;
		rm /run/openvpn-$x/peer.pid;
	fi
done;
