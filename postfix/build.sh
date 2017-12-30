echo -e "\nBuilding image...\n"
# docker build
#   -t       # Name and optionally a tag in the 'name:tag' format
#   .        # <path>
docker build \
  -t postfix \
  .

if [ $? != 0 ]; then echo "Failed"; exit 1; fi


echo -e "\nStopping container...\n"
# docker stop \
#   postfix  # <container_name>
docker stop \
  postfix


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
  -d \
  -i \
  -t \
  -p 25:25 \
  --volume compose_postfix_creds:/postfix_creds:nocopy \
  --rm \
  --name postfix \
  postfix

if [ $? != 0 ]; then echo "Failed"; exit 1; fi
