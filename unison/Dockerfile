FROM resin/rpi-raspbian

# ##############################################################################
# Install all the base packages needed for the following installs
# Set up timezone

RUN \
  apt-get update && \
  apt-get install \
    vim \
    unzip \
    wget && \
  cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
  echo "Europe/Berlin" > /etc/timezone

WORKDIR /source

# ##############################################################################
# Install unison stable from http://www.seas.upenn.edu/~bcpierce/unison/download/releases/stable/

RUN \
  apt-get install \
    emacs \
    make \
    ocaml

RUN \
  wget http://www.seas.upenn.edu/~bcpierce/unison/download/releases/stable/unison-2.48.4.tar.gz && \
  tar xf unison-2.48.4.tar.gz && \
  cd src && \
  make UISTYLE=text && \
  cp unison unison-fsmonitor /usr/local/bin

RUN \
  apt-get remove \
    emacs \
    make \
    ocaml && \
  apt-get autoremove

# ##############################################################################
# Install and configure sshd

WORKDIR /

RUN \
  apt-get install \
    openssh-server \
    rsyslog && \
  mkdir mkdir /var/run/sshd && \
  mkdir /root/.ssh && \
  chmod 700 /root/.ssh

COPY environment /root/.ssh/
COPY sshd_config /etc/ssh/
COPY start.sh /

COPY docker_container_profile /root/.profile
# CMD ["/bin/bash", "-l"]

ENTRYPOINT ["/start.sh"]

EXPOSE 1499
VOLUME /var/musik /var/sshd_certs /root/.unison
