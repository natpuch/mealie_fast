FROM ubuntu:20.04

WORKDIR "/root"


RUN DEBIAN_FRONTEND=noninteractive; apt-get update; apt-get -y install wget curl

COPY install_scripts/install_apache.sh /root/install_apache.sh

RUN chmod +x install_apache.sh

RUN ./install_apache.sh

COPY install_scripts/install_BoS.sh /root/install_BoS.sh

RUN chmod +x install_BoS.sh

RUN ./install_BoS.sh

RUN DEBIAN_FRONTEND=noninteractive; apt-get clean; apt-get autoremove

RUN echo "service apache2 restart" >> /root/.bashrc

WORKDIR "/root"

COPY install_scripts/start.sh /root/start.sh

WORKDIR "/var/www/html"

WORKDIR "/root"

RUN chmod +x start.sh

CMD ["./start.sh"]
