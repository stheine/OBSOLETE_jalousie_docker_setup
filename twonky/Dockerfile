FROM resin/rpi-raspbian

RUN \
  apt-get update && \
  apt-get install \
    vim \
    unzip \
    wget && \
  mkdir /source

# ##############################################################################
# Set up timezone

RUN \
  cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
  echo "Europe/Berlin" > /etc/timezone

# ##############################################################################
# Install and run twonky from http://www.twonkyforum.com/downloads/
# Get the url of the package 'Linux ARM little endian glibc 2.13 HF (Raspbian)'

RUN \
  cd /source && \
  wget http://www.twonkyforum.com/downloads/8.5/twonky-armel-glibc-2.13-hf-8.5.zip && \
  mkdir /twonky && \
  cd /twonky && \
  unzip /source/twonky-armel-glibc-2.13-hf-8.5.zip

EXPOSE 1030/udp 1900/udp 9000/tcp
VOLUME /mnt/nas_fritzbox
VOLUME /var/twonky

COPY docker_container_profile /root/.profile
# CMD ["/bin/bash", "-l"]

ENTRYPOINT ["/twonky/twonkyserver"]
