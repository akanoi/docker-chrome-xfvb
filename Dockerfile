FROM ubuntu:16.04

ENV CHROME_PACKAGE="google-chrome-stable_75.0.3770.142-1_amd64.deb"
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

RUN apt-get update && \
    apt-get install -y xvfb wget supervisor x11vnc && \
    wget https://github.com/webnicer/chrome-downloads/raw/master/x64.deb/${CHROME_PACKAGE} && \
    dpkg --unpack ${CHROME_PACKAGE} && \
    apt-get install -f -y && \
    apt-get clean && \
    rm ${CHROME_PACKAGE}

RUN mkdir /supervisor
RUN mkdir /logs
RUN mkdir /logs/supervisor/

COPY supervisor /supervisor
COPY supervisord.conf /etc/supervisord.conf

RUN useradd -ms /bin/bash newuser
USER newuser
WORKDIR /home/newuser

RUN ls . 
