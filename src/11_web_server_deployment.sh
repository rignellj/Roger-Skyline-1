#!/bin/bash

# This script creates the ssl certificate and configures apache

PARAMS="/etc/apache2/conf-available/ssl-params.conf"
VIRTUALHOST="/etc/apache2/sites-available/default-ssl.conf"
REDIRECT="/etc/apache2/sites-available/000-default.conf"

if [ -s ${PARAMS} ]
then
        /usr/bin/printf "\n${RED}\nDeployment stop. Config already set up.\n\n${NC}"
        /usr/bin/echo "Exiting with status 1"
        STATUS_SYMBOLS[9]=${ATTENTION}
        return 1
fi

/usr/bin/printf "\n${WHITE}\nCreating the SSL Certificate${NC}"
start_and_stop_animation dot 2
/usr/bin/sudo /usr/bin/openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt

/usr/bin/printf "\n${WHITE}\nGenerating ${PARAMS}${NC}"
start_and_stop_animation dot 2

/usr/bin/echo "SSLCipherSuite EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH
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

/usr/bin/printf "\n${WHITE}\nCreating ${VIRTUALHOST} backup file${NC}"
start_and_stop_animation dot 2

/usr/bin/cp "${VIRTUALHOST}" "${VIRTUALHOST}.bak"

/usr/bin/echo ""
read -p "Give your email address: " EMAIL
read -p "Give your IP or server domain name: " IP

/usr/bin/echo "<IfModule mod_ssl.c>
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

/usr/bin/printf "\n${WHITE}\nCreating redirection ${REDIRECT} backup file and editing current file${NC}"
start_and_stop_animation dot 2

/usr/bin/sudo /usr/bin/sed -i.bak "/DocumentRoot \/var\/www\/html/a Redirect \"/\" https:\/\/"${IP}"\/" ${REDIRECT}

/usr/bin/printf "\n${WHITE}\nOK\n${NC}"
/bin/sleep 1

/usr/bin/printf "\n${WHITE}\nEnabling the Changes in Apache${NC}"
start_and_stop_animation dot 2

/usr/bin/sudo a2enmod ssl
/usr/bin/sudo a2enmod headers
/usr/bin/sudo a2ensite default-ssl
/usr/bin/sudo a2enconf ssl-params

/usr/bin/printf "\n${WHITE}\nRestarting apache${NC}"
start_and_stop_animation dot 1
/usr/bin/sudo /usr/bin/systemctl restart apache2

/usr/bin/printf "\n${WHITE}\nLet's test changes${NC}"
start_and_stop_animation dot 1
TEST=$(/usr/bin/sudo apache2ctl configtest)

if [ ${TEST} != "Syntax OK" ]
then
        /usr/bin/echo "There was an error"
        /usr/bin/echo "ServerName localhost" >> /etc/apache2/apache2.conf
        /usr/bin/sudo /usr/bin/systemctl restart apache2
        /usr/bin/printf "\n${WHITE}\nLet's test changes AGAIN${NC}"
        start_and_stop_animation dot 1
        TEST=$(/usr/bin/sudo apache2ctl configtest)
        if [ ${TEST} != "Syntax OK" ]
        then
                STATUS_SYMBOLS[9]=${ATTENTION}
                /usr/bin/printf "\n${WHITE}\nSet up done\n${NC}"
                return 0
        fi
fi

/usr/bin/printf "\n${WHITE}\nSet up done\n${NC}"
STATUS_SYMBOLS[9]=${SUCCESS}
