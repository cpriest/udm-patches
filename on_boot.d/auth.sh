#!/bin/sh

PKG_DIR=/mnt/data/udm-patches

# Append the contents of root/.ssh/authorized_keys and root/.profile to /root/... files
cat ${PKG_DIR}/root/.ssh/authorized_keys >> /root/.ssh/authorized_keys
cat ${PKG_DIR}/root/.profile >> /root/.profile
