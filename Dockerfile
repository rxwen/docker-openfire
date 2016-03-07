FROM ubuntu
MAINTAINER Raymond Wen

ENV OPENFIRE_VERSION 4.0.1
RUN sed -i 's/archive.ubuntu.com/mirrors.163.com/' /etc/apt/sources.list \
 && echo 'APT::Install-Recommends 0;' >> /etc/apt/apt.conf.d/01norecommends \
 && echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends \
 && apt-get update \
 && apt-get install -y vim.tiny wget sudo net-tools ca-certificates unzip \
 && wget https://github.com/tianon/gosu/releases/download/1.4/gosu-amd64 -O /usr/local/bin/gosu \
 && chmod +x /usr/local/bin/gosu
RUN apt-get install -y openjdk-7-jre \
 && wget "http://www.igniterealtime.org/downloadServlet?filename=openfire/openfire_${OPENFIRE_VERSION}_all.deb" \
      -O /tmp/openfire_${OPENFIRE_VERSION}_all.deb \
 && dpkg -i /tmp/openfire_${OPENFIRE_VERSION}_all.deb \
 && rm -rf openfire_${OPENFIRE_VERSION}_all.deb \
 && rm -rf /var/lib/apt/lists/*

ADD start /start
RUN chmod 755 /start

EXPOSE 3478
EXPOSE 3479
EXPOSE 5222
EXPOSE 5223
EXPOSE 5229
EXPOSE 7070
EXPOSE 7443
EXPOSE 7777
EXPOSE 9090
EXPOSE 9091

VOLUME ["/data"]
CMD ["/start"]
