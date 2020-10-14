#!/bin/bash

# This script configures everything that is needed for web server.

source status.sh

source src/1_intro.sh
status 1

source src/2_add_sudouser.sh
status 2

source src/3_configure_interfaces.sh
source src/4_configure_static_ip.sh
status 2.4

source src/5_ssh_configure.sh
status 2.6

source src/6_firewall_rules.sh
status 2.8

source src/7_fail2ban.sh
status 3

source src/8_portscans.sh
status 3.2

source src/9_disable_services.sh
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
