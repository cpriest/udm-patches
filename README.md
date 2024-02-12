# Ubiquiti Dream Machine Pro onboot.d scripts

This repository contains on boot scripts which handle various things, see below for more details.

# Archived

This patch is no longer necessary as the UDM Pro now has proper OpenVPN client capabilities built-in.

## Installation
1. First install the excellent UDM [on-boot-script](https://github.com/boostchicken/udm-utilities/tree/master/on-boot-script) package from [boostchicken/udm-utilities](https://github.com/boostchicken/udm-utilities).
2. Download this repository and adjust its configuration to your needs.
3. Edit the `install.sh` script and change the `ROUTER` to your routers IP address and run `install.sh`
4. Login to your UDM via ssh and run the on_boot.d scripts to activate them.

   They should persist across reboots and firmware updates per the on_boot project.

## on\_boot.d\auth.vpn

This script appends the authorized\_keys file in udm-patches\root-ssh to the root authorized_keys file upon boot.

## on\_boot.d\openvpn.sh

This script installs the openvpn-wrapper.sh symlink to intercept UDM openvpn start/stop requests and allows you to use an entirely customized OpenVPN config file (.ovpn) while keeping it integrated with the UDM OS.

You should setup an openvpn-N directory within udm-patches with your custom openvpn.conf file.

See the existing [openvpn-N](udm-patches/openvpn-N/openvpn-1.conf) file for instructions to modify your own config file.

If you only have one VPN connection, the directory would be openvpn-1. If you have multiple tunnels you may override
any or all of them by creating the appropriate `openvpn-N` directory where `N` corresponds to the tunnel number in use by the UDM.

Once your configuration file is ready and in place, create a new site to site OpenVPN in the UDM gui using any parameters
that will allow you to save.  The wrapper script will re-route the openvpn call to utilize your custom config and setup tunnel
masquerading.  It is assumed that the server you are connecting to will push the routes to the UDM.

### Troubleshooting
If you are having trouble with the connection, you can see the output of the last intercepted openvpn run by looking at the file `/tmp/openvpn-orig.log` on the base alpine image which is a redirect of the openvpn command output.
