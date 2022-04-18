FROM ubuntu
RUN apt update

RUN ln -snf /usr/share/zoneinfo/$(curl https://ipapi.co/timezone) /etc/localtime

RUN apt install -y build-essential
RUN apt install -y libcairo2-dev
RUN apt install -y libjpeg-turbo8-dev
RUN apt install -y libpng-dev
RUN apt install -y libtool-bin
RUN apt install -y libossp-uuid-dev
RUN apt install -y libvncserver-dev
RUN apt install -y freerdp2-dev
RUN apt install -y libssh2-1-dev
RUN apt install -y libtelnet-dev
RUN apt install -y libwebsockets-dev
RUN apt install -y libpulse-dev
RUN apt install -y libvorbis-dev
RUN apt install -y libwebp-dev
RUN apt install -y libssl-dev
RUN apt install -y libpango1.0-dev
RUN apt install -y libswscale-dev
RUN apt install -y libavcodec-dev
RUN apt install -y libavutil-dev
RUN apt install -y libavformat-dev
RUN apt install -y wget
RUN apt install -y automake
RUN apt install -y tomcat9 
RUN apt install -y tomcat9-admin
RUN apt install -y tomcat9-common
RUN apt install -y tomcat9-user


WORKDIR /build
RUN wget https://downloads.apache.org/guacamole/1.3.0/source/guacamole-server-1.3.0.tar.gz
RUN tar -xvf guacamole-server-1.3.0.tar.gz
WORKDIR /build/guacamole-server-1.3.0
RUN ./configure --with-init-dir=/etc/init.d --enable-allow-freerdp-snapshots
RUN make
RUN make install
RUN ldconfig

RUN tomcat9-instance-create /tomcat
RUN wget https://downloads.apache.org/guacamole/1.3.0/binary/guacamole-1.3.0.war
RUN mv guacamole-1.3.0.war /tomcat/webapps/guacamole.war

COPY startup.sh startup.sh
RUN chmod +x startup.sh

RUN mkdir /etc/guacamole
RUN touch /etc/guacamole/user-mapping.xml

CMD [ "./startup.sh" ]