FROM node:8.9.3-alpine

# ##############################################################################
# Install all the base packages needed for the following installs
# Set up timezone

RUN \
  apk update && \
  apk add \
    bash \
    ca-certificates \
    tzdata \
    vim \
    wget && \
  cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
  echo "Europe/Berlin" > /etc/timezone && \
  apk del tzdata

WORKDIR /source

# ##############################################################################
# Install pigpio from http://abyz.me.uk/rpi/pigpio/index.html

RUN \
  apk add \
    gcc \
    make \
    musl-dev && \
  wget abyz.co.uk/rpi/pigpio/pigpio.zip && \
  unzip pigpio.zip && \
  cd PIGPIO && \
  /bin/cat Makefile | sed 's/ldconfig//' > Makefile.tmp && \
  mv Makefile.tmp Makefile && \
  make && \
  make install

# ##############################################################################
# Install rrdtool from https://github.com/oetiker/rrdtool-1.x

RUN \
  apk add \
    g++ \
    groff \
    libpng-dev \
    libxml2-dev \
    make \
    pango-dev \
    pcre-dev \
    perl-dev && \
  wget https://github.com/oetiker/rrdtool-1.x/releases/download/v1.7.0/rrdtool-1.7.0.tar.gz && \
  tar xf rrdtool-1.7.0.tar.gz && \
  cd rrdtool-1.7.0 && \
  ./configure --prefix=/opt/rrdtool && \
  /bin/cat src/Makefile | sed 's/^LIBS = $/LIBS = -lintl/' > src/Makefile.tmp && \
  mv src/Makefile.tmp src/Makefile && \
  make && \
  make install && \
  ln -s /opt/rrdtool/include/rrd.h /usr/include/ && \
  ln -s /opt/rrdtool/lib/librrd.so /usr/lib/ && \
  ln -s /opt/rrdtool/lib/librrd.so.8 /usr/lib/ && \
  ln -s /opt/rrdtool/lib/librrd.so.8.1.0 /usr/lib/

# ##############################################################################
# Install and run jalousie app

# This command is just to invalidate the cache and force docker to rebuild the app from here on
# docker-compose build --build-arg CACHE_DATE_JS="$(date)" jalousie
ARG CACHE_DATE_JS=2018-01-20

WORKDIR /jalousie_prepare

# Speed up the installation by preinstalling some large libs and saving this as a layer in docker.
RUN \
  apk add \
    git \
    python && \
  npm init --yes && \
  npm install \
    @stheine/pigpiod \
    rrdtools

# This command is just to invalidate the cache and force docker to rebuild the app from here on
# docker-compose build --build-arg CACHE_DATE="$(date)" jalousie
ARG CACHE_DATE=2018-01-20

WORKDIR /

RUN \
  git clone https://github.com/stheine/jalousie.git && \
  cd /jalousie && \
  mv /jalousie_prepare/node_modules . && \
  npm install --production

COPY vimrc /root/.vimrc

COPY docker_container_profile /root/.profile
# CMD ["/bin/bash", "-l"]

CMD ["/usr/local/bin/node", "/jalousie/lib/jalousie.js"]

EXPOSE 9124
VOLUME /var/jalousie /var/vito
