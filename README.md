# Shell_Scripts for Web Server Deployment

There are two distinct ways of configuring web server:
1. You can just copy three lines of code from section below `OR`
2. You can follow the manual which come after Contents section

## Configure Web Server Using Scripts

```
cd && apt install sudo && sudo apt update && sudo apt upgrade && sudo apt-get install git -y
git clone https://github.com/rignellj/Roger-Skyline-1.git scripts && cd scripts
./roger_skyline_1.sh
```

#### Contents

1.  [**Introduction**](#introduction)
2.  [**Creating Nonroot User**](#adduser)
3.  [**Configure a Static IP**](#staticIP)
4.  [**Change the SSH Default Port and Setup SSH Access With Publickeys**](#sshPubkey)
5.  [**Firewall Setup With UFW**](#ufw)
6.  [**DOS (Denial Of Service Attack) protection**](#DOS)
7.  [**Protection Against Port Scans**](#portScans)
8.  [**Disable the Services We Don’t Need**](#DisableServices)
9.  [**Update Packages & Monitor Crontab Changes Scripts**](#cronScript)
10. [**Self-signed SSL and Debloyment**](#SSL)
11. [**Deployment Automation**](#automate)

### Introduction <a id="introduction"></a>
1. This part first installs required packages to your Linux Debian and also checks partitions
2. Running `./1_intro.sh` will update & upgrade packages and also installs software
that is needed for this project

### Let's Create Nonroot User <a id="adduser"></a>
Run `./2_add_sudouser.sh` to create given user and give sudo privilages to the user

### Configure a Static IP <a id="staticIP"></a>
1. Run `./3_configure_interfaces.sh` to configure `/etc/network/interfaces` file
2. Next run `./4_configure_static_ip.sh`. This will prompt IP address, Netmask and Gateway and configures with given addresses.

### Change the SSH Default Port and Setup SSH Access With Publickeys <a id="sshPubkey"></a>
1. Before moving to next step, user needs to create new ssh public key. Script will also ask to do this.
2. Run `./5_ssh_configure.sh` to reset SSH port number

### Denial Of Service Attack (DOS) protection & Firewall rules <a id="DOS"></a>
1. Run `./6_firewall_rules.sh` to set up firewall rules
2. Then `./7_fail2ban.sh` will handle all the config for the DOS which will protect your open ports of your VM.

### Protection Against Port Scans <a id="portScans"></a>
1. `./8_portscans.sh` will set protection against scans on your VM’s open ports.

### Disable the Services We Don’t Need <a id="DisableServices"></a>
1. `./9_disable_services.sh`--> This script disables unnecessary services.

### Update Packages & Monitor Crontab Changes Scripts <a id="cronScript"></a>
1. Running `./10_cron_conf.sh` will add few tasks to crontab file

### Self-signed SSL and Debloyment <a id="SSL"></a>
1. Running `./11_web_server_deployment.sh` will set self-signed SSL and also will handle all the config according to that.

### Deployment Automation <a id="automate"></a>
1. Running `./12_files_copy.sh` will start process which will ask user certain questions according from which machine to copy, which SSH ports to use, what is the result of $(whoami) on remote (host) and the full path to files to copy.


*********************
                                                      **End of Deployment**
*********************
