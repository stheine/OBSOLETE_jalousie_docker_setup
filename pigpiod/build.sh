echo -e "\nBuilding image...\n"
# docker build
#   -t       # Name and optionally a tag in the 'name:tag' format
#   .        # <path>
docker build \
  -t pigpiod \
  .

if [ $? != 0 ]; then echo "Failed"; exit 1; fi


echo -e "\nStopping container...\n"
# docker stop \
#   pigpiod  # <container_name>
docker stop \
  pigpiod


echo -e "\nRunning container...\n"
# docker run
#  -d        # Run container in background and print container ID
#  -i        # Keep STDIN open even if not attached
#  -t        # Allocate a pseudo-TTY
#  -p        # Publish a container's port(s) to the host
#  --mount   # Attach a filesystem mount to the container
#  --rm      # Automatically remove the container when it exits
#  --name    # Assign a name to the container
#  pigpiod   # <image>
docker run \
  -i \
  -t \
  --cap-add SYS_RAWIO \
  --device /dev/mem \
  --device /dev/vcio \
   -p 8888:8888 \
  --rm \
  --name pigpiod \
  pigpiod

#  -d \

if [ $? != 0 ]; then echo "Failed"; exit 1; fi
