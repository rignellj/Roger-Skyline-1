#!/bin/bash

# This script creates the ssl certificate and configures apache

WHITE="\033[1;37m"
RED="\033[1;31m"
RESET="\033[0m"

PARAMS="/etc/apache2/conf-available/ssl-params.conf"
VIRTUALHOST="/etc/apache2/sites-available/default-ssl.conf"
REDIRECT="/etc/apache2/sites-available/000-default.conf"

if [ -s ${PARAMS} ]
then
        printf "\n${RED}\nDeployment stop. Config already set up.\n\n${RESET}"
        echo "Exiting with status 1"
        exit 1
fi

printf "\n${WHITE}\nCreating the SSL Certificate...\n\n${RESET}"
sleep 2
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt

printf "\n${WHITE}\nGenerating ${PARAMS}...\n\n${RESET}"
sleep 2

echo "SSLCipherSuite EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH
SSLProtocol All -SSLv2 -SSLv3 -TLSv1 -TLSv1.1
SSLHonorCipherOrder On
# Disable preloading HSTS for now.  You can use the commented out header line that includes
# the \"preload\" directive if you understand the implications.
# Header always set Strict-Transport-Security \"max-age=63072000; includeSubDomains; preload\"
Header always set X-Frame-Options DENY
Header always set X-Content-Type-Options nosniff
# Requires Apache >= 2.4
SSLCompression off
SSLUseStapling on
SSLStaplingCache \"shmcb:logs/stapling-cache(150000)\"
# Requires Apache >= 2.4.11
SSLSessionTickets Off" > ${PARAMS}

printf "\n${WHITE}\nCreating ${VIRTUALHOST} backup file...\n\n${RESET}"
sleep 2

cp "${VIRTUALHOST}" "${VIRTUALHOST}.bak"

read -p "Give your email address: " EMAIL
read -p "Give your IP or server domain name: " IP

echo "<IfModule mod_ssl.c>
        <VirtualHost _default_:443>
                ServerAdmin ${EMAIL}
                ServerName ${IP}

                DocumentRoot /var/www/html

                ErrorLog ${APACHE_LOG_DIR}/error.log
                CustomLog ${APACHE_LOG_DIR}/access.log combined

                SSLEngine on

                SSLCertificateFile      /etc/ssl/certs/apache-selfsigned.crt
                SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key

                <FilesMatch \"\.(cgi|shtml|phtml|php)$\">
                                SSLOptions +StdEnvVars
                </FilesMatch>
                <Directory /usr/lib/cgi-bin>
                                SSLOptions +StdEnvVars
                </Directory>

        </VirtualHost>
</IfModule>" > ${VIRTUALHOST}

printf "\n${WHITE}\nCreating redirection ${REDIRECT} backup file and editing current file...\n\n${RESET}"
sleep 2

sed -i.bak "/DocumentRoot \/var\/www\/html/a Redirect \"/\" https:\/\/"${IP}"\/" ${REDIRECT}

printf "\n${WHITE}\nOK\n${RESET}"
sleep 1

printf "\n${WHITE}\nEnabling the Changes in Apache...\n${RESET}"
sleep 2

a2enmod ssl
a2enmod headers
a2ensite default-ssl
a2enconf ssl-params

printf "\n${WHITE}\nRestarting apache...\n${RESET}"
sleep 1
systemctl restart apache2

printf "\n${WHITE}\nLet's test changes...\n${RESET}"
sleep 1
TEST=$(apache2ctl configtest)

if [ ${TEST} != "Syntax OK" ]
then
        echo "There was an error"
        echo "ServerName localhost" >> /etc/apache2/apache2.conf
        systemctl restart apache2
        printf "\n${WHITE}\nLet's test changes AGAIN...\n${RESET}"
        sleep 1
        apache2ctl configtest
fi

printf "\n${WHITE}\nSet up done\n${RESET}"
read -p "Press enter to continue: " ENTER
