FROM anapsix/alpine-java
MAINTAINER Raymond Wen

ENV OPENFIRE_VERSION 4_1_0
RUN apk update && apk add ca-certificates wget
RUN wget http://www.igniterealtime.org/downloadServlet?filename=openfire/openfire_${OPENFIRE_VERSION}.tar.gz -O /openfire.tar.gz && tar xvf /openfire.tar.gz && rm /openfire.tar.gz
# hazelcast plugin must be named hazelcast.jar
# list of openfire plugins: http://www.igniterealtime.org/projects/openfire/plugins.jsp
RUN wget http://www.igniterealtime.org/projects/openfire/plugins/hazelcast.jar -O /openfire/plugins/hazelcast.jar
RUN wget https://www.igniterealtime.org/projects/openfire/plugins/restAPI.jar -O /openfire/plugins/restAPI.jar
RUN wget https://www.igniterealtime.org/projects/openfire/plugins/presence.jar -O /openfire/plugins/presence.jar
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

CMD ["/start"]
