## Basic Docker Commands

### 1. Create and start a new container from an image.

```bash
docker run <Image-name>
docker run -p  <host-port>:<container-port> <Image-name>

docker run -d -p <host-port>:<container-port> <Image-name>

```

+ Here -p is stand for port mapping
+ Here -d is stand for detached-mod which means container will run in the background


### 2. Start an existing stopped container.
```bash
docker start <conatiner-name/container-id>
```

### 3. Stop a running container gracefully.

```bash
docker stop <conatiner-name/container-id>
```

### 4. Restart a container.
```bash
docker restart <conatiner-name/container-id>
```

### 5. Pause all processes within a container.
```bash
docker pause <conatiner-name/container-id>
```

### 6. Unpause all processes within a container.
```bash
docker unpause <conatiner-name/container-id>
```
### 7. List running containers.
```bash
docker ps
```

### 8. List all containers (running and stopped).
```bash
docker ps -a
```

### 9. List all images on the local system.
```bash
docker images
```

### 10. Pull an image from a registry.
```bash
docker pull <image-name>
```

### 11. Push an image to a registry.
```bash
docker push <image-name>:tagname
```
### 12.  Build an image from a Dockerfile where you have created Dockerfile you can run this command

```bash
docker build -t . <name you want to keep for image>
```
### 13. docker exec - Run a command in a running container.

```bash
docker exec -it <contianer-name>
```

+ here -it stands for 

   + i: interactive mode
   + t: terminal 

+ docker logs - Fetch the logs of a container.

```bash
docker logs -f <container_name_or_id>
```
+ Follow (-f) :It continuously outputs new log entries as they are written to the container's log, rather than just displaying the current logs and exiting.


### 14. docker rm - Remove one or more containers.

```bash
docker rm <contianer_name_or_id>
```

### 15.docker rmi - Remove one or more images.

```bash
docker rmi <Image-name>
```

### 16.docker volume ls - List all volumes.

```bash
docker volume ls
```

### 17. docker inspect - Display detailed information on one or more containers or images.

```bash
docker inspect <conatiner_name_or_id>
```

### 18. docker diff - Show changes to files and directories in a container's filesystem.

```bash
docker diff <container_name_or_id>
```
+ lists the file system changes made within a running Docker container since its creation, indicating added, modified, or deleted files compared to its image

### 19.  docker top - Display the running processes of a container.

```bash
docker top <container_name_or_id>
```
+ used to display the running processes within a Docker container. It shows a list of processes running inside the specified container, similar to the top command on Unix-like systems but scoped to the container's context

### 20. docker stats - Display a live stream of container(s) resource usage statistics.

```bash
docker stats
```
+ is used to display a live stream of container resource usage statistics. When run without specifying a container name or ID, it shows CPU, memory, network I/O, and disk I/O usage of all running containers.

### 21. docker version - Show the Docker version information.

```bash
docker version
```

### 22 .docker info - Display system-wide information about Docker.

```bash
docker info
```

### 23. docker cp - Copy files/folders between a container and the local filesystem.

```bash
docker cp <container_name_or_id>:/path/to/container/file /path/on/host
```

### 24. docker rename - Rename a container.
```bash
docker rename <current_container_name_or_id> <new_container_name>
```

### 25. docker wait - Block until a container stops, then print its exit code.

```bash
docker wait <container_name_or_id>
```

### 26. docker attach - Attach local standard input, output, and error streams to a running container.

```bash
docker attach <container_name_or_id>
```
### 27. docker export - Export a container's filesystem as a tar archive.
```bash
docker export <container_name_or_id> > exported_container.tar
```

### 28. docker commit - Create a new image from a container's changes (not recommended for production use, use Dockerfile instead).

```bash
docker commit <container_name_or_id> <new_image_name>:<tag>
```

### 29. docker login - Log in to a Docker registry.
```bash
docker login <registry_url>
```

### 30. docker logout - Log out from a Docker registry.
```bash
docker logout <registry_url>
```

### 31. docker tag - Tag an image into a repository.
```bash
docker tag <image_name>:<tag> <registry_url>/<repository>/<image_name>:<tag>
```

### 32. docker system df - Show Docker disk usage.

```bash
docker system df
```

### 33 .docker system prune - Remove unused data (containers, networks, images, and volumes).

```bash
docker system prune
```



## Docker Networking Commands

### 1. List all networks.

```bash
docker network ls  
```  
### 2. Display detailed information about a network

```bash
docker network inspect <network-id or network-name> 
```

### 3. Create a new network.

```bash
docker network create <network-name> 
```

### 4. Connect a container to a network.
```bash
docker network connect <network-name> <container-name or container-id>
```

### 5. Disconnect a container from a network.
```bash
docker network disconnect <network-name> <container-name or container-id> 
```

### 6. Remove one or more networks.

```bash
docker network rm <network-name>  
```

### 7. Remove all unused networks.

```bash
docker network prune 
```