# Shell_Scripts Web Server Deployment

## #Contents

- [Introduction](#introduction)
- [Creating Nonroot User](#adduser)
- [Configure a Static IP](#staticIP)
- [Change the SSH Default Port](#sshPort)
- [Setup SSH Access With Publickeys](#sshPubkey)
- [Firewall Setup With UFW](#ufw)
- [DOS (Denial Of Service Attack) protection](#DOS)
- [Protection Against Port Scans](#scanSecure)
- [Disable the Services We Don’t Need](#DisableServices)
- [Update Packages Script](#updateScript)
- [Monitor Crontab Changes Script](#cronScript)
- [Self-signed SSL and Debloyment](#apache)
- [Deployment Automation](#automation)

## #Introduction <a id="introduction"></a>
1. This part first installs required packages to your Linux Debian
2. Running `sudo ./intro.sh` will update & upgrade packages and also installs software
that is needed for this project

## #Let's create Nonroot User <a id="adduser"></a>
Run `sudo ./add_sudouser.sh` to create given user and give sudo privilages to the user

