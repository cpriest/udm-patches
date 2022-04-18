#!/bin/bash

ROUTER="192.168.210.1";
BASE_DIR="/mnt/data";

set -x;
# echo "Copying ./on_boot.d scripts to $BASE_DIR/on_boot.d on $ROUTER...";
scp -p -r ./on_boot.d/* root@$ROUTER:/mnt/data/on_boot.d;
# echo;

# echo "Copying ./udm-patches/  to $BASE_DIR/udm-patches/ on $ROUTER...";
scp -p -r ./udm-patches/ root@$ROUTER:/mnt/data/;

# echo "Setting +x on scripts...";
ssh root@$ROUTER "chmod -v +x $BASE_DIR/on_boot.d/* $BASE_DIR/udm-patches/scripts/*";
