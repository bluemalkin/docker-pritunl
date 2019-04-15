FROM ubuntu:xenial

MAINTAINER Tom Murphy <tom@bluemalkin.net>

RUN apt-get update && \
  apt-get install -y dirmngr curl procps iptables && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A  && \
  echo "deb http://repo.pritunl.com/stable/apt xenial main" >  /etc/apt/sources.list.d/pritunl.list && \
  apt-get update && \
  apt-get -y install pritunl || apt-get -f -y install && \
  apt-get -y autoremove && \
  rm -rf /var/lib/apt/lists/*

EXPOSE 80/tcp 443/tcp
EXPOSE 1194/udp

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/usr/bin/tail", "-f","/var/log/pritunl.log"]
