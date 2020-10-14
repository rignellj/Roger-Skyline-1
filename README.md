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
2. Running `./intro.sh` will update & upgrade packages and also installs software
that is needed for this project

### Let's Create Nonroot User <a id="adduser"></a>
Run `sudo ./add_sudouser.sh` to create given user and give sudo privilages to the user

### Configure a Static IP <a id="staticIP"></a>
1. Run `sudo ./configure_interfaces.sh` to configure `/etc/network/interfaces` file
2. Next run `sudo ./configure_static_ip.sh`. This will prompt IP address, Netmask and Gateway and configures with given addresses.

### Change the SSH Default Port and Setup SSH Access With Publickeys <a id="sshPubkey"></a>
1. Before moving to next step, user needs to create new ssh public key. Script will also ask to do this.
2. Run `./ssh_configure.sh` to reset SSH port number

### Denial Of Service Attack (DOS) protection <a id="DOS"></a>

### Protection Against Port Scans <a id="portScans"></a>

### Disable the Services We Don’t Need <a id="DisableServices"></a>

### Update Packages & Monitor Crontab Changes Scripts <a id="cronScript"></a>

### Self-signed SSL and Debloyment <a id="SSL"></a>

### Deployment Automation <a id="automate"></a>

