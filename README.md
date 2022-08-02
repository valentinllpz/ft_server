# ft_server

This [42](https://42.fr/en/homepage/) project teached us how to build a web server from scratches with a Dockerfile.
The server will run with Debian Buster, Nginx, Mysql or Mariadb, phpMyAdmin and Wordpress. It must use the SSL protocole when it's possible.

## 🧭 Usage

1. Clone this repo and access it with `cd`
2. Run `docker build -t ft-server:latest .` to build the image. This may take a while.
3. To run this image in a container working in background use `docker run -d --name="vlugand-" --rm -p 80:80 -p 443:443 ft-server`
4. To stop the container use `docker stop vlugand-`. 
5. You can remove the image with `docker rmi ft-server`.

## 📚 Ressources

- [Dockerfile best practices 2018](https://takacsmark.com/dockerfile-tutorial-by-example-dockerfile-best-practices-2018/)
- [LEMP stack tuto](https://takacsmark.com/dockerfile-tutorial-by-example-dockerfile-best-practices-2018/)
- [phpMyAdmin setup](https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-phpmyadmin-with-nginx-on-a-debian-9-server)
- [SSL explained](https://www.youtube.com/watch?v=T4Df5_cojAs)
- [SSL setup](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-on-debian-10)
- [Wordpress setup](https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lemp-nginx-mariadb-and-php-on-debian-10)
