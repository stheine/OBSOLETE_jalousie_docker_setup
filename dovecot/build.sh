echo -e "\nBuilding image...\n"
# docker build
#   -t       # Name and optionally a tag in the 'name:tag' format
#   .        # <path>
docker build \
  -t dovecot \
  .

if [ $? != 0 ]; then echo "Failed"; exit 1; fi


echo -e "\nStopping container...\n"
# docker stop \
#   dovecot  # <container_name>
docker stop \
  dovecot


echo -e "\nCreating volume...\n"
# https://docs.docker.com/engine/admin/volumes/volumes/
# https://docs.docker.com/engine/reference/commandline/volume_create/
docker volume create \
  --driver local \
  --opt type=nfs \
  --opt o=addr=192.168.6.22,rw \
  --opt device=:/nfs/Data/linux/vmail \
  vmail

if [ $? != 0 ]; then echo "Failed"; exit 1; fi


echo -e "\nRunning container...\n"
# docker run
#  -d        # Run container in background and print container ID
#  -i        # Keep STDIN open even if not attached
#  -t        # Allocate a pseudo-TTY
#  -p        # Publish a container's port(s) to the host
#  --mount   # Attach a filesystem mount to the container
#  --rm      # Automatically remove the container when it exits
#  --name    # Assign a name to the container
#  dovecot   # <image>
docker run \
  -d \
  -i \
  -t \
  -p 993:993 \
  --volume certs:/etc/dovecot/certs:nocopy \
  --volume vmail:/home/vmail:nocopy \
  --rm \
  --name dovecot \
  dovecot

#  --mount source=certs,target=/etc/dovecot/certs \
#  --mount source=vmail,target=/home/vmail,nocopy \

if [ $? != 0 ]; then echo "Failed"; exit 1; fi
