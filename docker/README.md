Using Dockerfile create the Docker image and then create the Docker containers.
run the application in Docker containers, so no need to setup extra development environment and configurations externally.   
for more details related to Docker please visit: https://www.docker.com/

# Steps for create Docker image and configure application in Docker container:
Please follow the below steps for create Docker image and execute application in Docker container

## Docker Installation

- Please note that before create the Docker image, Docker engine should be installed in local machine.   
  For Docker installation assistance and more details please visit my blog: [Docker_setup](https://github.com/AppayRocks/Yesod_Elm_App/blob/master/docs/Docker_blog.md)
  
  If Docker Installation done, then Cheers all set to GO...!!!
  
## Build Docker Image
  
 - All you need is dockerfile 'Yesod_Elm_App/docker/Dockerfile', copy this file in target machine.
 - Build image using below command
 
   ``` $ docker build -t yesod_elm_app:1.0  /<path_to_dockerfile>/Dockerfile ```
   
## Run Docker container
   After successful Docker image build, run Docker container
   
 - Run container
 
   ``` $ docker run -it -p 53001:53001 yesod_elm_app:1.0 /bin/bash ```   
   success of above command will take you in Docker container
   
## Clone the git repository and build the App

 - Clone the app repository
   
   ``` $ git clone https://github.com/AppayRocks/Yesod_Elm_App.git app ```
   
 - Build the front code first
 
   ``` $ cd app/elmFront/ && make ```

 - Build the server
 
   ``` $ cd ../myserver/ && stack build ```
   
## Run the application

 - Start the postgreSQL server
 
   ``` service postgresql start ```
   
 - Start the server
 
   ``` stack exec -- myserver ```
   
## Access application

 - Access the app using URL: http://localhost:53001/
 
.
. If you could access the app contents then ⇩ ,,, else try again ⇧

# Cheers...!!! well done :)
 
