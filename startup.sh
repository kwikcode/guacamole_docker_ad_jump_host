#!/usr/bin/env bash

echo "test"

cat >/etc/guacamole/user-mapping.xml <<EOL
<user-mapping>

<!-- Example user configurations are given below. For more information,
     see the user-mapping.xml section of the Guacamole configuration
     documentation: http://guac-dev.org/Configuring%20Guacamole -->

<!-- Per-user authentication and config information -->
<authorize username="USER1" password="PASSWORD">
    <protocol>rdp</protocol>
    <param name="hostname">192.168.1.90</param>
    <param name="port">3389</param>
</authorize>

<!-- Another user, but using md5 to hash the password
     (example below uses the md5 hash of "PASSWORD") -->
<authorize
        username="USERNAME2"
        password="319f4d26e3c536b5dd871bb2c52e3178"
        encoding="md5">
    <protocol>vnc</protocol>
    <param name="hostname">localhost</param>
    <param name="port">5901</param>
    <param name="password">VNCPASS</param>
</authorize>

</user-mapping>
EOL


guacd
/tomcat/bin/startup.sh

read -s -n 1 -p "Press any key to continue . . ."