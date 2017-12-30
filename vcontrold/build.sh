echo -e "\nBuilding image...\n"
# docker build
#   -t       # Name and optionally a tag in the 'name:tag' format
#   .        # <path>
docker build \
  -t vcontrold \
  .

if [ $? != 0 ]; then echo "Failed"; exit 1; fi


echo -e "\nStopping container...\n"
# docker stop \
#   vcontrold  # <container_name>
docker stop \
  vcontrold


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
  -p 3002:3002 \
  --device /dev/ttyAMA0:/dev/ttyAMA0 \
  --device /dev/ttyS0:/dev/ttyS0 \
  --device /dev/serial0:/dev/serial0 \
  --device /dev/serial1:/dev/serial1 \
  --network=compose_backend \
  --rm \
  --name vcontrold \
  vcontrold

#  -d \

if [ $? != 0 ]; then echo "Failed"; exit 1; fi
