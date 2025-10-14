FROM debian:12

RUN apt-get update && apt-get install -y mariadb-server

COPY ./config/50-server.cnf /etc/mysql/mariadb.conf.d/

# RUN sed -ir "s/bind-address = 127.0.0.1/bind-address = 0.0.0.0\r\nport = 3306/1" \
# /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/SetupDataBase.sh /root/
RUN chmod +x /root/SetupDataBase.sh

CMD [ "/root/SetupDataBase.sh" ]