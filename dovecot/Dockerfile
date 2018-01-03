FROM arm32v6/alpine:3.6

# ##############################################################################
# Install all the base packages needed for the following installs
# Set up timezone
RUN \
  apk update && \
  apk add \
    bash \
    dovecot \
    shadow \
    tzdata && \
  cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
  echo "Europe/Berlin" > /etc/timezone && \
  apk del tzdata

# ##############################################################################
# Configure and run dovecot

RUN useradd -m -p vmail -s /bin/false vmail

COPY dovecot.conf passwd /etc/dovecot/
COPY ssl-parameters.dat /var/lib/dovecot/ssl-parameters.dat

COPY docker_container_profile /root/.profile
# CMD ["/bin/bash", "-l"]

ENTRYPOINT ["/usr/sbin/dovecot", "-F"]

EXPOSE 993
VOLUME /etc/dovecot/certs /home/vmail
