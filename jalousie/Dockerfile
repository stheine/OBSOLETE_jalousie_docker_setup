FROM node:8.9.3-alpine

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
  cd /source && \
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
# Set up timezone

RUN \
  apk add tzdata && \
  cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
  echo "Europe/Berlin" > /etc/timezone && \
  apk del tzdata

# ##############################################################################
# Install and run jalousie app

# This command is just to invalidate the cache and force docker to rebuild the app from here on
ADD https://www.random.org/strings/?num=16&len=16&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new uuid

RUN \
  apk add \
    git \
    python && \
  git clone https://github.com/stheine/jalousie.git && \
  cd /jalousie && \
  npm install

# ##############################################################################
# Setting for development environment
RUN \
  apk add \
    vim && \
  npm install --global \
    eslint-cli && \
  git config --global user.email "stheine@arcor.de" && \
  git config --global user.name "Stefan Heine" && \
  git config --global core.pager "more"

COPY vimrc /root/.vimrc

COPY docker_container_profile /root/.profile
# CMD ["/bin/bash", "-l"]

ENTRYPOINT ["/usr/local/bin/node", "/jalousie/lib/jalousie.js"]

EXPOSE 9124
VOLUME /var/jalousie
VOLUME /var/vito
