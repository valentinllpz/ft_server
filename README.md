# HOW TO DO THIS PROJECT 

This project will teach you how to build a web server from scratches with a Dockerfile.
The server will run with Debian Buster, Nginx, Mysql or Mariadb, phpMyAdmin and Wordpress. It must use the SSL protocole when it's possible.

1. First things first, you should understand what is Docker and how it works. Go read articles or watch videos about it.
2. Next, you need to understand what is a Dockerfile and how to make your own. This tutorial helped me a lot: https://takacsmark.com/dockerfile-tutorial-by-example-dockerfile-best-practices-2018/
3. Once you've set up your Dockerfile with Debian Buster you can follow this tutorial to install the LEMP stack: https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-ubuntu-18-04
4. I'd recommend you to use the name "localhost" for your server to make things easier for now. You can access it with http://localhost
5. Let's install phpMyAdmin, here's a tutorial: https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-phpmyadmin-with-nginx-on-a-debian-9-server
6. Now you should check out a few videos to understand how HTTPS and SSL work. I found this one helpful for instance: https://www.youtube.com/watch?v=T4Df5_cojAs
7. You can proceed with the SSL setup for your server by following this tutorial: https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-on-debian-10
8. Finally, you can install Wordpress: https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lemp-nginx-mariadb-and-php-on-debian-10
9. Follow the installation steps of Wordpress and try making your first dummy article. Then export your wordpress database with phpMyAdmin. This will allow you to make sure you'have done everything right.
10. Don't forget to set the autoindex on in your Nginx conf file.

nb: I don't have the pretention to say that's the only or best way to proceed, but that's simply the way I did it. :)
You should make your own researches in order to fully undersand all the concepts introduced with this project. 

# HOW TO USE

1. Open the terminal and go to the folder of this Dockerfile
2. From there run "docker build -t ft-server:latest ." to build the image. This may take a while.
3. To run this image in a container working in background use "docker run -d --name="vlugand-" --rm -p 80:80 -p 443:443 ft-server".
4. To stop the container use "docker stop vlugand-". 
5. You can remove the image with "docker rmi ft-server".
