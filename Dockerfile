FROM ubuntu:bionic

ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

# RUN mkdir /ffserver

RUN set -ex \
  && apt-get update
RUN apt install -y \
      net-tools \
      ffmpeg \
      iputils-ping \
      vim \
      openvpn

COPY ffserver/ffserver.conf /etc/
COPY ovpn/* /etc/openvpn/
      
RUN echo AUTOSTART=all | tee -a /etc/default/openvpn

EXPOSE 9950
EXPOSE 9951

WORKDIR /usr/bin
RUN echo "#!/bin/bash" > /tmp/start_script.sh
RUN echo "/etc/init.d/openvpn status" >> /tmp/start_script.sh
RUN echo "sleep 1" >> /tmp/start_script.sh
RUN echo "/etc/init.d/openvpn restart && sleep 5" >> /tmp/start_script.sh
RUN echo "cd /usr/bin" >> /tmp/start_script.sh
# RUN echo "/usr/bin/ffserver -d" >> /tmp/start_script.sh
RUN chmod +x /tmp/start_script.sh

ENTRYPOINT /tmp/start_script.sh && /bin/bash # ffserver -d

