echo -e "\nBuilding image...\n"
# docker build
#   -t       # Name and optionally a tag in the 'name:tag' format
#   .        # <path>
docker build \
  -t nginx \
  .

if [ $? != 0 ]; then echo "Failed"; exit 1; fi


echo -e "\nStopping container...\n"
# docker stop \
#   nginx  # <container_name>
docker stop \
  nginx


echo -e "\nCreating volume...\n"
# https://docs.docker.com/engine/admin/volumes/volumes/
# https://docs.docker.com/engine/reference/commandline/volume_create/
docker volume create \
  --driver local \
  --opt type=nfs \
  --opt o=addr=192.168.6.22,ro \
  --opt device=:/nfs/Data/linux/certs \
  certs

if [ $? != 0 ]; then echo "Failed"; exit 1; fi


echo -e "\nRunning container...\n"
# docker run
#  -d        # Run container in background and print container ID
#  -i        # Keep STDIN open even if not attached
#  -t        # Allocate a pseudo-TTY
#  -p        # Publish a container's port(s) to the host
#  --network # Connect a container to a network
#  --mount   # Attach a filesystem mount to the container
#  --rm      # Automatically remove the container when it exits
#  --name    # Assign a name to the container
#  apache2   # <image>
docker run \
  -i \
  -t \
  -p 80:80 \
  -p 443:443 \
  --network=compose_backend \
  --volume certs:/etc/nginx/certs:nocopy \
  --link compose_apache2_1 \
  --rm \
  --name nginx \
  nginx

# -d \

if [ $? != 0 ]; then echo "Failed"; exit 1; fi
