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
## Images commands
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