# WODockerApp
## _WebObjects mvn deployment in Docker with minimal amount of components_

The project aims to show how WebObjects applications can be run in Docker containers. This deployment showcases how you can run your WebObjects application on Docker on multiple hosts with a minimum amount of components and docker native scaling options.

## Demo App
For demonsration porposes was created simple mvn based application which includes:
 - 1 WebServerResource
 - 1 external library(JUnit)
 - 1 simple junit test

Application versions:
 - java11
 - WebObjects 5.4.3
 - Wonder 7.4

The application's session is stored in cookies and the page is showing the hostname of the instance it is running on.

## Docker Images 

### womvnenvironment
This image contains all settings to have WebObjects mvn enabled and additionaly preloaded wonder7.4 and WebObjects5.4.3 frameworks. 

### Quick Start
#### docker-compose
To run the application for demonstration purposes simply use docker-compose
```sh
docker-compose up
```
#### Docker Swarm
The application can be also run in the docker swarm mode. In this case, you would be able to scale your application instances easier. 
```sh
docker swarm init
docker stack deploy -c stack.yml webobjects
```
Each of these commands will create a stack with services that expose following endpoints:
 - _127.0.0.1/apps/WebObjects/wodockerapp.woa_ demo application which is already running.
