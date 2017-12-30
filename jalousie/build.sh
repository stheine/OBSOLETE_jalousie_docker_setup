echo -e "\nBuilding image...\n"
# docker build
#   -t       # Name and optionally a tag in the 'name:tag' format
#   .        # <path>
docker build \
  -t jalousie \
  .

if [ $? != 0 ]; then echo "Failed"; exit 1; fi


echo -e "\nStopping container...\n"
# docker stop \
#   jalousie  # <container_name>
docker stop \
  jalousie


echo -e "\nRunning container...\n"
# docker run
#  -d        # Run container in background and print container ID
#  -i        # Keep STDIN open even if not attached
#  -t        # Allocate a pseudo-TTY
#  -p        # Publish a container's port(s) to the host
#  --device  # Add a host device to the container
#  --network # Connect a container to a network
#  --mount   # Attach a filesystem mount to the container
#  --rm      # Automatically remove the container when it exits
#  --name    # Assign a name to the container
#  apache2   # <image>
docker run \
  -i \
  -t \
  -p 9124:9124 \
  --volume compose_jalousie:/var/jalousie:nocopy \
  --volume compose_vito:/var/vito:nocopy,ro \
  --network=compose_backend \
  --link=compose_postfix_1 \
  --link=compose_pigpiod_1 \
  --rm \
  --name jalousie \
  jalousie

if [ $? != 0 ]; then echo "Failed"; exit 1; fi

# TODO daemon  -d \
