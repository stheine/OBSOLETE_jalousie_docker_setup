FROM tobi312/rpi-nginx:alpine

# ##############################################################################
# Install all the base packages needed for the following installs
# Set up timezone

RUN \
  apk update && \
  apk add \
    bash \
    tzdata && \
  cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
  echo "Europe/Berlin" > /etc/timezone && \
  apk del tzdata

# ##############################################################################
# Configure and run nginx

COPY nginx.conf /etc/nginx/

COPY docker_container_profile /root/.profile
# CMD ["/bin/bash", "-l"]

EXPOSE 80 443
VOLUME /etc/nginx/certs
