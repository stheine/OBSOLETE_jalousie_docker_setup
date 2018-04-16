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
# Install and run twonky from http://www.twonkyforum.com/downloads/
# Get the url of the package 'Linux ARM little endian glibc 2.13 HF (Raspbian)'

RUN \
  wget http://www.twonkyforum.com/downloads/8.3/twonky-armel-glibc-2.13-hf-8.3.zip

WORKDIR /twonky

RUN \
  unzip /source/twonky-armel-glibc-2.13-hf-8.3.zip

COPY docker_container_profile /root/.profile
# CMD ["/bin/bash", "-l"]

ENTRYPOINT ["/twonky/twonkyserver"]

EXPOSE 1030/udp 1900/udp 9000/tcp
VOLUME /mnt/nas_fritzbox /var/twonky/twonkyserver
