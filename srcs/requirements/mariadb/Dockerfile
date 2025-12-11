FROM debian:12

RUN apt-get update && apt-get install -y mariadb-server

COPY ./config/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/SetupDataBase.sh /root/
RUN chmod +x /root/SetupDataBase.sh

CMD [ "/root/SetupDataBase.sh" ]