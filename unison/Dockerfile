FROM resin/rpi-raspbian

# ##############################################################################
# Install all the base packages needed for the following installs
# Set up timezone

RUN \
  apt update && \
  apt install \
    vim \
    unzip \
    wget && \
  cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
  echo "Europe/Berlin" > /etc/timezone

# ##############################################################################
# Install and configure sshd

WORKDIR /

RUN \
  apt install \
    openssh-server \
    rsyslog && \
  mkdir mkdir /var/run/sshd && \
  mkdir /root/.ssh && \
  chmod 700 /root/.ssh

COPY environment /root/.ssh/
COPY sshd_config /etc/ssh/
COPY start.sh /

# ##############################################################################
# Install unison stable from https://github.com/bcpierce00/unison
# unison and ucaml must be built on the same version on server and client.
# on the remote is unison 2.48.4 with ocaml 4.05.
# ocaml 4.05 is currently available only in the testing channel.

RUN \
  cd /etc/apt/apt.conf.d/ && \
  echo 'APT::Default-Release "jessie";' > 99defaultrelease && \
  cd /etc/apt/sources.list.d/ && \
  echo 'deb http://ftp.de.debian.org/debian testing main contrib non-free' > testing.list && \
  gpg --list-keys && \
  gpg --keyserver pgpkeys.mit.edu --recv-key 8B48AD6246925553 && \
  gpg -a --export 8B48AD6246925553 | sudo apt-key add - && \
  gpg --keyserver pgpkeys.mit.edu --recv-key 7638D0442B90D010 && \
  gpg -a --export 7638D0442B90D010 | sudo apt-key add - && \
  gpg --keyserver pgpkeys.mit.edu --recv-key 04EE7237B7D453EC && \
  gpg -a --export 04EE7237B7D453EC | sudo apt-key add - && \
  apt update && \
  apt -t testing install ocaml && \
  apt install emacs make

WORKDIR /source

RUN \
  wget https://github.com/bcpierce00/unison/archive/2.48.4.tar.gz && \
  tar xf 2.48.4.tar.gz && \
  cd unison-2.48.4/src && \
  make UISTYLE=text && \
  cp unison unison-fsmonitor /usr/local/bin && \
  apt remove \
    emacs \
    make \
    ocaml && \
  cd /source && \
  rm 2.48.4.tar.gz
#  apt autoremove && \

COPY docker_container_profile /root/.profile
# CMD ["/bin/bash", "-l"]

ENTRYPOINT ["/start.sh"]

EXPOSE 1499
VOLUME /var/musik /var/sshd_certs /root/.unison
