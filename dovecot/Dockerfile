FROM arm32v6/alpine:3.6

RUN apk update && \
  apk add --no-cache \
    dovecot \
    shadow

# ##############################################################################
# Set up timezone

RUN \
  apk add tzdata && \
  cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
  echo "Europe/Berlin" > /etc/timezone && \
  apk del tzdata

# ##############################################################################
# Configure and run dovecot

RUN useradd -m -p vmail -s /bin/false vmail

EXPOSE 993
VOLUME /etc/dovecot/certs
VOLUME /home/vmail

COPY dovecot.conf /etc/dovecot/
COPY passwd /etc/dovecot/
COPY ssl-parameters.dat /var/lib/dovecot/ssl-parameters.dat

COPY docker_container_profile /root/.profile
# CMD ["/bin/bash", "-l"]

CMD ["/usr/sbin/dovecot", "-F"]
