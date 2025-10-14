FROM debian:12

RUN apt-get update && apt-get install nginx openssl -y

COPY ./conf/wordpress /etc/nginx/sites-available/

COPY ./conf/nginx-selfsigned.crt /etc/ssl/certs/
COPY ./conf/nginx-selfsigned.key /etc/ssl/private/

RUN ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/


CMD [ "nginx", "-g daemon off;" ]