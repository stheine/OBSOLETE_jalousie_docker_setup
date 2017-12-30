echo -e "\nBuilding image...\n"
# docker build
#   -t       # Name and optionally a tag in the 'name:tag' format
#   .        # <path>
docker build \
  -t apache2 \
  .


echo -e "\nStopping container...\n"
# docker stop \
#   apache2  # <container_name>
docker stop \
  apache2


echo -e "\nCreating volume...\n"
# https://docs.docker.com/engine/admin/volumes/volumes/
# https://docs.docker.com/engine/reference/commandline/volume_create/
docker volume create \
  --driver local \
  --opt type=nfs \
  --opt o=addr=192.168.6.22,ro \
  --opt device=:/nfs/Data/linux/www \
  www


echo -e "\nRunning container...\n"
# docker run
#  -d        # Run container in background and print container ID
#  -i        # Keep STDIN open even if not attached
#  -t        # Allocate a pseudo-TTY
#  -p        # Publish a container's port(s) to the host
#  --mount   # Attach a filesystem mount to the container
#  --rm      # Automatically remove the container when it exits
#  --name    # Assign a name to the container
#  apache2   # <image>
docker run \
  -d \
  -i \
  -t \
  -p 8080:8080 \
  --mount source=www,target=/var/www \
  --rm \
  --name apache2 \
  apache2
