FROM ubuntu:latest
LABEL MAINTAINER="salmaan.iitkgp@gmail.com"


#why is r there
RUN mkdir -p /home/BAN/var/logs \
    && groupadd -g 100054 -r BAN \
    && useradd salmaan -u 100054 -r -g BAN -d /home/BAN \
    && chmod 755 /home/BAN/var/logs \
    && chown salmaan:BAN /home/BAN/var/logs

WORKDIR /home/BAN
COPY . /home/BAN/

RUN ls -ltr

COPY she.sh /home/BAN/

RUN apt-get update

RUN apt-get install -y nginx

RUN apt-get install -y systemctl

EXPOSE 80

#CMD sed -i -e 's/\r$//' she.sh \
#       && ./she.sh
#CMD systemctl start nginx.service

ENTRYPOINT nginx -c /etc/nginx/nginx.conf -g "daemon off;"
