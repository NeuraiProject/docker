# Docker for Neurai blockbook

This docker allows to have blockbook installed in a docker and to be able to access it from any computer without compatibility problems and with few operations.

----
## Basic commands

### Create image
Necessary to be in the same directory as the Dockerfile file
``docker build -t blockbook .``

### Create container
Create a container named blockbook-neurai with volume to store the data downloaded from the node.
``docker run -it -v blockbook:/data --name blockbook-neurai blockbook``

### List volumes
Allows to know which volumes are created in the system.
``docker volume ls``

### List containers
Indicates the containers created in the system
``docker container ps``

### Know the ip of the container
The IP will be of the style 172.17.0.2 and to enter in the blockbook explorer it would be necessary to enter in: https://172.17.0.2:9168
``docker inspect <id_container or name_container>``

### Entering a container
During the execution of a container, it is possible to enter it from another terminal.
``docker exec -it <container_id_or name_container> /bin/bash``

### Reopen a container
When a container is closed and you want to continue where it was.
``docker start <container_id>``

### Delete containers and images
``docker system purge --all``