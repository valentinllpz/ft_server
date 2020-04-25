FROM debian:buster
LABEL maintainer="vlugand-@student.42.fr"

### PREREQUISITES ###

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y wget && \
	apt-get install -y nginx && \
	apt-get install -y mariadb-server && \
	apt-get install -y php php-fpm php-mysql php-gd php-soap php-curl php-gd php-cli php-mbstring php-xml php-xmlrpc php-zip && \
	wget -qP /tmp https://files.phpmyadmin.net/phpMyAdmin/4.9.1/phpMyAdmin-4.9.1-english.tar.gz && \
	wget -qP /tmp https://wordpress.org/latest.tar.gz

### PHPMYADMIN SETUP ###

RUN mkdir -p var/www/localhost/phpmyadmin && \
	tar -zxf /tmp/phpMyAdmin-4.9.1-english.tar.gz --strip-components=1 -C /var/www/localhost/phpmyadmin && \
	rm /tmp/phpMyAdmin-4.9.1-english.tar.gz && \
	mkdir var/www/localhost/phpmyadmin/tmp && \
	chmod 777 var/www/localhost/phpmyadmin/tmp/
COPY srcs/config.inc.php var/www/localhost/phpmyadmin

### MARIADB SETUP ###

COPY srcs/wordpress.sql /tmp
RUN service mysql start && \
	mariadb < /var/www/localhost/phpmyadmin/sql/create_tables.sql && \
	mariadb -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" && \
	mariadb wordpress < /tmp/wordpress.sql && \
	rm /tmp/wordpress.sql && \
	mariadb -e "GRANT ALL ON phpmyadmin.* TO 'pma'@'localhost' IDENTIFIED BY 'pmapass';" && \
	mariadb -e "GRANT ALL ON wordpress.* TO 'wp_user'@'localhost' IDENTIFIED BY 'password';" && \
	mariadb -e "GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY '' WITH GRANT OPTION;" && \
	mariadb -u root -e "FLUSH PRIVILEGES;"

### OPENSSL SETUP ###

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75017/L=Paris/O=42/CN=localhost' -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt >/dev/null 2>&1
RUN openssl dhparam -out /etc/nginx/dhparam.pem 1024 >/dev/null 2>&1

### WORDPRESS SETUP ###

RUN tar -zxf /tmp/latest.tar.gz -C /var/www/localhost/ && \
	rm /tmp/latest.tar.gz
COPY srcs/wp-config.php /var/www/localhost/wordpress/

### NGINX SETUP ###

COPY srcs/localhost /etc/nginx/sites-available/
COPY srcs/self-signed.conf /etc/nginx/snippets/
COPY srcs/ssl-params.conf /etc/nginx/snippets/
RUN ln -s /etc/nginx/sites-available/localhost  /etc/nginx/sites-enabled/ && \
	chown -R www-data:www-data var/www/localhost

### DOCKER CONF ###

EXPOSE 80 443
COPY srcs/start_services.sh /tmp/
CMD bash "/tmp/start_services.sh"

### HOW TO USE ###

# 1. Open the terminal and go to the folder of this Dockerfile
# 2. From there run "docker build -t ft-server:latest ." to build the image. This may take a while.
# 3. To run this image in a container working in background use "docker run -d --name="vlugand-" --rm -p 80:80 -p 443:443 ft-server".
# 4. To stop the container use "docker stop vlugand-". 
# 5. You can remove the image with "docker rmi ft-server".
