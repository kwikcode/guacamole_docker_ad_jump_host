#!/usr/bin/env bash
set -e

cat >/etc/guacamole/user-mapping.xml <<EOL

<user-mapping>

    <!-- Per-user authentication and config information -->
    <authorize username="USERNAME" password="PASSWORD">
        <protocol>vnc</protocol>
        <param name="hostname">localhost</param>
        <param name="port">5900</param>
        <param name="password">VNCPASS</param>
    </authorize>

    <!-- Another user, but using md5 to hash the password
         (example below uses the md5 hash of "PASSWORD") -->
    <authorize
            username="USERNAME2"
            password="319f4d26e3c536b5dd871bb2c52e3178"
            encoding="md5">

        <!-- First authorized connection -->
        <connection name="ad1">
            <protocol>rdp</protocol>
            <param name="hostname">dc1.mydomain.com</param>
            <param name="port">3389</param>
            <param name="username">myuser</param>
            <param name="password">mypw</param>
            <param name="domain">mydomain.com</param>
            <param name="security">nla</param>
            <param name="ignore-cert">true</param>
        </connection>

        <connection name="ad2">
            <protocol>rdp</protocol>
            <param name="hostname">dc2.mydomain.com</param>
            <param name="port">3389</param>
            <param name="username">myuser</param>
            <param name="password">pw!</param>
            <param name="domain">mydomain.com</param>
            <param name="security">nla</param>
            <param name="ignore-cert">true</param>
        </connection>


    </authorize>

</user-mapping>

EOL

echo "Starting guacd (background)"
guacd

echo "Starting tomcat (foreground)"
export CATALINA_BASE="/tomcat"

# For background:
#/tomcat/bin/startup.sh
#read -s -n 1 -p "Press any key to continue . . ."

# Start [CMD] passed in
exec "$@"