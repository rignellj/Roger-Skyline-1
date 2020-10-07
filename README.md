# Shell_Scripts Web Server Deployment

## #Contents

- [Introduction](#introduction)
- [Creating Nonroot User](#adduser)
- [Configure a Static IP](#staticIP)
- [Change the SSH Default Port and Setup SSH Access With Publickeys](#sshPubkey)
- [Firewall Setup With UFW](#ufw)
- [DOS (Denial Of Service Attack) protection](#DOS)
- [Protection Against Port Scans](#scanSecure)
- [Disable the Services We Don’t Need](#DisableServices)
- [Update Packages Script](#updateScript)
- [Monitor Crontab Changes Script](#cronScript)
- [Self-signed SSL and Debloyment](#apache)
- [Deployment Automation](#automation)

## #Introduction <a id="introduction"></a>
1. This part first installs required packages to your Linux Debian and also checks partitions
2. Running `sudo ./intro.sh` will update & upgrade packages and also installs software
that is needed for this project

## #Let's Create Nonroot User <a id="adduser"></a>
Run `sudo ./add_sudouser.sh` to create given user and give sudo privilages to the user

## #Configure a Static IP <a id="staticIP"></a>
1. Run `sudo ./configure_interfaces.sh` to configure `/etc/network/interfaces` file
2. Next run `sudo ./configure_static_ip.sh`. This will prompt IP address, Netmask and Gateway and configures with given addresses.

## #Change the SSH Default Port and Setup SSH Access With Publickeys <a id="sshPubkey"></a>
1. Before moving to next step, user needs to create new ssh public key. Script will also ask to do this.
2. Run `./ssh_configure.sh` to reset SSH port number
