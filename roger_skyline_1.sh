#!/bin/bash

# This script configures everything that is needed for web server.

source status.sh

source src/01_intro.sh
status 1

source src/02_add_sudouser.sh
status 2

source src/03_configure_interfaces.sh
source src/04_configure_static_ip.sh
status 2.4

source src/05_ssh_configure.sh
status 2.6

source src/06_firewall_rules.sh
status 2.8

source src/07_fail2ban.sh
status 3

source src/08_portscans.sh
status 3.2

source src/09_disable_services.sh
status 3.4

source src/10_cron_conf.sh
status 3.6

source src/11_web_server_deployment.sh
status 3.8

source src/12_files_copy.sh
status 4

echo "*********************"
echo "* End of Deployment *"
echo "*********************"
