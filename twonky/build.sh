echo -e "\nBuilding image...\n"
# docker build
#   -t       # Name and optionally a tag in the 'name:tag' format
#   .        # <path>
docker build \
  -t twonky \
  .

if [ $? != 0 ]; then echo "Failed"; exit 1; fi


echo -e "\nStopping container...\n"
# docker stop \
#   twonky  # <container_name>
docker stop \
  twonky


echo -e "\nRunning container...\n"
# docker run
#  -d        # Run container in background and print container ID
#  -i        # Keep STDIN open even if not attached
#  -t        # Allocate a pseudo-TTY
#  -p        # Publish a container's port(s) to the host
#  --mount   # Attach a filesystem mount to the container
#  --rm      # Automatically remove the container when it exits
#  --name    # Assign a name to the container
#  twonky   # <image>
docker run \
  -i \
  -t \
  -p 1030:1030/udp \
  -p 1900:1900/udp \
  -p 9000:9000 \
  --volume docker_twonky:/var/twonky:nocopy \
  --rm \
  --name twonky \
  twonky

#  -d \
#  -p 993:993 \
#  --volume certs:/etc/dovecot/certs:nocopy \
#  --volume vmail:/home/vmail:nocopy \
if [ $? != 0 ]; then echo "Failed"; exit 1; fi
