FROM arm32v6/alpine:3.6

# ##############################################################################
# Install all the base packages needed for the following installs
RUN apk update && \
  apk add \
    bash \
    ca-certificates \
    wget

RUN \
  mkdir /source

# ##############################################################################
# Install vcontrold from https://github.com/openv/vcontrold

RUN \
  apk add \
    cmake \
    gcc \
    libxml2-dev \
    linux-headers \
    make \
    musl-dev && \
  cd /source && \
  wget https://github.com/openv/vcontrold/releases/download/v0.98.4/vcontrold_0.98.4.orig.tar.gz && \
  tar xf vcontrold_0.98.4.orig.tar.gz && \
  cd vcontrold-0.98.4 && \
  mkdir build && \
  cd build && \
  cmake -DMANPAGES=OFF .. && \
  make && \
  make install

COPY \
  etc_vcontrold/vcontrold.xml \
  etc_vcontrold/vito.xml \
  /etc/vcontrold/

# ##############################################################################
# Set up timezone

RUN \
  apk add tzdata && \
  cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
  echo "Europe/Berlin" > /etc/timezone && \
  apk del tzdata

# ##############################################################################
# Run vcontrold

EXPOSE 3002
VOLUME /var/vito

COPY docker_container_profile /root/.profile
# CMD ["/bin/bash", "-l"]

# CMD ["/usr/sbin/vcontrold", "--nodaemon", "--verbose"]
CMD ["/usr/sbin/vcontrold", "--nodaemon"]
