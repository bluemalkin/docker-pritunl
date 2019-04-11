FROM debian:stretch-slim

MAINTAINER Tom Murphy <tom@bluemalkin.net>

ENV PRITUNL_VERSION="1.29.2026.90"

RUN apt-get update && \
  apt-get install -y dirmngr curl && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A  && \
  echo "deb http://repo.pritunl.com/stable/apt stretch main" >  /etc/apt/sources.list.d/pritunl.list && \
  apt-get update && \
  apt-get install -y pritunl=${PRITUNL_VERSION}-0debian1~stretch || apt-get -f -y install && \
  rm -rf /var/lib/apt/lists/*

EXPOSE 80/tcp
EXPOSE 443/tcp
EXPOSE 1194/udp

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/usr/bin/pritunl", "start", "-c", "/etc/pritunl.conf"]
