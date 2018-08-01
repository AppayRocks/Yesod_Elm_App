# What is Docker?

[Docker](https://www.docker.com/) is a tool designed to make it easier to create, deploy, and run applications by using containers. Containers allow a developer to package up an application with all of the parts it needs, such as libraries and other dependencies, and ship it all out as one package. By doing so, thanks to the container, the developer can rest assured that the application will run on any other Linux machine regardless of any customized settings that machine might have that could differ from the machine used for writing and testing the code.

In a way, Docker is a bit like a virtual machine. But unlike a virtual machine, rather than creating a whole virtual operating system, Docker allows applications to use the same Linux kernel as the system that they're running on and only requires applications be shipped with things not already running on the host computer. This gives a significant performance boost and reduces the size of the application.

And importantly, Docker is open source. This means that anyone can contribute to Docker and extend it to meet their own needs if they need additional features that aren't available out of the box.


# Some Important Docker commands:
-	all Docker config data stored in '/var/lib/docker'

## Docker Installation:::

 - Uninstall old versions if any
 
      ``` $ sudo apt-get remove docker docker-engine docker.io ```
             
 - Install latest Docker              
 
      ``` $ apt install docker.io ```
      
    Or  (use curl script to install docker as below -> https://get.docker.com)
        
      ``` $ curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh ```
      
	  Or
    
      ``` $ curl -fsSL get.docker.com -o get-docker.sh | sh ```
   
   
      
 - Create user for docker having admin right  ($ id user_name   ->  to verify)
         
      ``` $ usermod -aG docker user_name ```
                                          

##	Docker Pull:::

 - to pull images from docker hub: https://hub.docker.com/

      ``` $ docker pull image_name ```
      
    e.g.
    
      ``` $ docker pull ubuntu:14.0 ```
     
 - to see all images which pulled or present in local machine
   
      ``` $ docker images ```
      
 - to delete image file
    
      ``` $ docker rmi image_name ```
      

##	Docker run:::

 - to create and start docker container
    
      ``` $ docker run -it ubuntu:14.04 /bin/bash ```   
                        (interactive mode i.e. -it parameter)
                        
     Or 
     
      ``` docker run -it ubuntu:latest /bin/bash ```   
      
     Or
     
      ``` docker run -d -it --name=app1 ubuntu:latest /bin/bash ```   
                           (de-attach mode i.e. -d parameter)
                           
     Or
               
      ``` docker run -it -v /data --name=app2 ubuntu /bin/bash ```   
           (create storage directory '/data' which will be exist after exit from container in '/var/lib/docker/volumes')
                    
     Or 
     
      ``` docker run -it -v /vilas:/data --name=app3 ubuntu /bin/bash ```   
                   (attach host sub directory '/root/vilas' to container as '/data')


##	Docker restart:::
 
 - to restart stopped container

      ``` $ docker restart container_name ```
     

##	Docker ps:::

 - List all running docker container
 
     ``` $ docker ps ```
     
 - List all running and closed docker container
 
     ``` $ docker ps -a ```


##	Docker start and attach:::

 - Run killed container (in background)
 
    ``` $ docker start container_id/name ```
    
     then
  
    ``` $ docker attach container_id/name ```   
        (to enter in running container)


##	Docker stop:::

 - to stop the container (command line)
 
    ``` $ docker stop container_id/name ```
    
 - short cut to exit container
 
      CTRL + P + Q        -> to exit container without end it (not kill)   
      CTRL + D            -> to exit container with end it (do kill)
           

##	Docker commit:::

 - to create new Image form existing container
 
    ``` $ docker commit container_id/container_name  new_image_name:version ```
    
     Or   
 
    ``` $ docker commit -a "Student" -m "a message" container_id/container_name  new_img_name:version ```
    

##	Docker import/export:::
   
 - Export images (this is flatten image no metadata saved)
 
    ``` $ docker export image_name > img_name.tar ```
    
 - Import images
 
    ``` $ docker import img_name.tar own_image_name:latest ```


##	Docker save/load:::

 - Save the image (in this case will save all metadata which is not saved in case of export command)
 
    ``` $ docker save -o saved_img.tar img_name:latest ```
    
 - Load the image
 
    ``` $ docker load -i saved_img.tar ```
    

##	Docker push::: (steps to upload images to registry)
 
 - Create account on docker hub if not created : https://hub.docker.com/   
    
 - Login to docker account
 
    ``` $ docker login ```
    
 - rename docker image and tagging
 
    ``` $ docker tag own_image_name  docker.io/sub_dir/image_name:version ```   
                  **rename the docker image name before uploading and tag it like above (must stated with docker.io)
 
 - Push image to docker registry
 
    ``` $ docker push user_name_as_sub_dir/image_name:version ```


##	Docker Network connection:::
              
 - Network connection to docker and port forwarding
 
    ``` $ docker run -d -p 3306 -it mysql /bin/bash ```   
                 (assign port no to container for listen on port: 3306)
     Or
    
    ``` $ docker run -d -p 3306:3306 -it mysql /bin/bash ```   
		             (to map host and container ports host_port:container_port)

 - to see all IP config
 
    ``` $ iptables -L -t nat ```
   
 - to see all the interfaces ip
 
    ``` $ ip addr show ```


##	Docker Extra commands:::

 - to see top process of container
 
    ``` $ docker top container_id/container_name ```
   
 - to see changes done inside the container
 
    ``` $ docker diff container_id/container_name ```
   
 - to get all config(IP,. etc)
 
    ``` $ docker inspect container_id/container_name ```



##	Create Docker image from scratch::: (sample example)  
       Reference for all Dockerfile commands: https://docs.docker.com/engine/reference/builder/#usage
             
 -  create file called 'Dockerfile' (below are the sample Dockerfile contents)
 
        FROM ubuntu             ->  this is base image from/on top we will create own image    
                                    (every Dockerfile should start with FROM)
        CMD ["echo", "Hello World"]
        
     Or
     
     ** create script (make it executable) and copy in container and finally execute it
     
        FROM alpine
        
        COPY script.sh /script.sh
        
        CMD ["/script.sh"]

    
 - to build docker image
 
    ``` $ docker build Dockerfile ```
    
     Or 
        
    ``` $ docker build . ```   
            in the directory where 'Dockerfile' file is exist
            
     Or
     
    ``` $ docker build -t vilas/image_name:1.0 . ```   
              add tag value and give name to image
              
- create and run docker container
                       
    ``` docker run -it --name app1 image_id ```
    
    
##	Dangling image:::

    if once created an image and again it modified and build with same name and same dockerfile,
    then previous image become dangling image and it will loss it's tags, name etc.
    (can remove these dangling images for save memory)
    
 - remove dangling images
 
    ``` $ docker images --filter "dangling=true" ```
    
    ``` $ docker rmi image_id ```
    
     Or
     
    ``` $ docker rmi $(docker images -q --filter "dangling=true") ```   
                   to remove all dangling image (-q parameter will remove heading stuff from table)
     
 
##	Best practice:::    

      1. Add your changes of Dockerfile at the end of file, so it will not build entire image again from
         (it will start re-building from where you made the changes forward)
      
      2. try to combine multi line command in single one wherever possible
          (number of individual commands in Dockerfile that many intermediate images will created when build image)
          
       Example:
         FROM alpine:3.4
            MAINTAINER vilas sarwe.appay@gmail.com

            RUN apk update
            RUN apk add vim
            RUN apk add curl
            RUN apk add git
   
       or (best way =>>)
       
           FROM alpine:3.4
           MAINTAINER vilas sarwe.appay@gmail.com
   
          RUN apk update && \
                   apk add vim && \
                   apk add curl && \
                   apk add git
       or
       
         RUN apk update && \
             apk add vim curl git
             
      
  .  
  .   
  .
  ## **Thank you and Best of luck :)**
  
