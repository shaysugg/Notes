[whats docker](https://docs.docker.com/get-started/docker-overview/)
[After basics](https://docs.docker.com/get-started/introduction/whats-next/)
## Docker Objects
Images
An image is a read-only template with **instructions** for creating a Docker container.
Containers
A container os a **runnable** instance of an image. You can create, start, stop, move, or delete a container using the Docker API or CLI
Containers are isolated processes for each of your app's components.
## Getting started
* To start the project using the CLI
```shell
docker compose watch
```

Environment is basically a bunch of containers. For example it can be:
* React frontend - a Node container
* Node backend
* MySQL database
* phpMyAdmin
*They are working together to create a working application.*
*You can drop an environments and all the services that is required for an app to run would be ready.*

You can make changes and see them immediately because:
1) the processes running in each container are watching and responding to file changes
2) the files are shared with the containerized environment.

https://docs.docker.com/get-started/docker-concepts/the-basics/what-is-an-image/

## Running containers
`docker start` Starts an existing stopped container
`docker run` Creates and starts a new container from an image
example:
```shell
#first create new container from a specific image and start it
docker run -it --name my-container ubuntu:latest

#stop it
docker stop my-container

#later on if we wanted to start it again
docker start my-container
```

for running a docker compose
```shell
#run multiple containers that exists in a directory
docker compose up
```
Connect to a database container
```shell
docker exec -ti 9d1763981f7b psql -U postgres
```
## Images
```shell
#search
docker search docker/welcome-to-docker

#pull
docker pull docker/welcome-to-docker

#list of all imsges
docker image ls

#image's layers
docker image history docker/welcome-to-docker
```
### Image layers
1. The first layer adds basic commands and a package manager, such as apt.
2. The second layer installs a Python runtime and pip for dependency management.
3. The third layer copies in an application’s specific requirements.txt file.
4. The fourth layer installs that application’s specific dependencies.
5. The fifth layer copies in the actual source code of the application.

![[container_image_layers.webp]]
Sharing part of the layers: [[container_image_layer_reuse.webp]]
### Dockerfile
> A Dockerfile is a text-based document that's used to create a container image.

Example of a dockerfile
```dockerfile
FROM python:3.12
WORKDIR /usr/local/app

# Install the application dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy in the source code
COPY src ./src
EXPOSE 5000

# Setup an app user so the container doesn't run as the root user
RUN useradd app
USER app

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]
```
[[Dockerfile instructions]]

### Build images
For initing a template and create images run `docker init`
For building images from a directory `docker build .`
Use `-t` for naming images.

docker uses cache for faster builds. There are situations where cache can be invalidated. 
* Any changes to the command of a `RUN` instruction invalidates that layer.
* Any changes to files copied into the image with the `COPY` or `ADD` instructions.
**Once one layer is invalidated, all following layers are also invalidated.**

## Running containers
if we want to override the configuration of an image which defines a container we can pass some parameters when running the container by `docker run`
* Overriding ports
```shell
docker run -d -p HOST_PORT:CONTAINER_PORT postgres
```
* Setting environment values
```shell
docker run -e foo=bar postgres env
```
* Restricting to consume resources
```shell
docker run -e POSTGRES_PASSWORD=secret --memory="512m" --cpus="0.5" postgres
```
## Volumes
>Volumes are a storage mechanism that provide the ability to persist data beyond the lifecycle of an individual container.

attaching a volume to a container with `-v`
```shell
docker run --name=db -e POSTGRES_PASSWORD=secret -d -v postgres_data:/var/lib/postgresql/data postgres

#volume_name:path/to/volume
```
This one is more precise with newer syntax
```shell
docker run -dp 127.0.0.1:3000:3000 --mount type=volume,src=todo-db,target=/etc/todos getting-started

```
information about volume 
```shell
information about volume 
output:
[
    {
        "CreatedAt": "2025-08-11T18:07:50Z",
        "Driver": "local",
        "Labels": null,
        #actual location on host machine
        "Mountpoint": "/var/lib/docker/volumes/todo-db/_data",
        "Name": "todo-db",
        "Options": null,
        "Scope": "local"
    }
]
```
## Bind mounts
If you want to ensure that data generated or modified inside the container persists even after the container stops running, you would opt for a volume
If you have specific files or directories on your host system that you want to directly share with your container, like *configuration files or development code, then you would use a bind mount.

When using bind mount it's essential for docker to have access to the host directory.
In order to do so we can provide `:ro` `:rw`

example:
```shell
docker run -it --mount type=bind,src="$(pwd)",target=/src ubuntu bash
```
1. Launches an Ubuntu container
2. Opens an interactive bash shell
3. Mounts your current directory to /src inside the container
4. Allows you to work directly with your local files inside the container

[Example of bind mount in development](https://docs.docker.com/get-started/workshop/06_bind_mounts/#run-your-app-in-a-development-container)
## Multi container
before running multi containers we need a network for them all to communicate through
```shell
docker network create sample-app
```
