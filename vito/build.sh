echo -e "\nBuilding image...\n"
# docker build
#   -t       # Name and optionally a tag in the 'name:tag' format
#   .        # <path>
docker build \
  -t vito \
  .

if [ $? != 0 ]; then echo "Failed"; exit 1; fi


echo -e "\nStopping container...\n"
# docker stop \
#   vito  # <container_name>
docker stop \
  vito


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
  --volume compose_vito:/var/vito:nocopy \
  --network=compose_backend \
  --link=compose_postfix_1 \
  --link=compose_vcontrold_1 \
  --rm \
  --name vito \
  vito

if [ $? != 0 ]; then echo "Failed"; exit 1; fi

# TODO daemon  -d \
