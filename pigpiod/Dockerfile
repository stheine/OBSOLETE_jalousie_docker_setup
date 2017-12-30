FROM arm32v6/alpine:3.6

# ##############################################################################
# Install all the base packages needed for the following installs
RUN \
  apk update && \
  apk add \
    bash \
    ca-certificates \
    wget

RUN \
  mkdir /source

# ##############################################################################
# Install pigpio from http://abyz.me.uk/rpi/pigpio/index.html

RUN \
  apk add \
    gcc \
    make \
    musl-dev && \
  cd /source && \
  wget abyz.co.uk/rpi/pigpio/pigpio.zip && \
  unzip pigpio.zip && \
  cd PIGPIO && \
  /bin/cat Makefile | sed 's/ldconfig//' > Makefile.tmp && \
  mv Makefile.tmp Makefile && \
  make && \
  make install

# ##############################################################################
# Set up timezone

RUN \
  apk add tzdata && \
  cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
  echo "Europe/Berlin" > /etc/timezone && \
  apk del tzdata

# ##############################################################################
# Run pigpiod

EXPOSE 8888

COPY docker_container_profile /root/.profile
# CMD ["/bin/bash", "-l"]

CMD ["/usr/local/bin/pigpiod", "-g"]
