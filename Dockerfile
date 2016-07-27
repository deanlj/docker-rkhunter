#
# Dockerfile for rkhunter 
#

FROM ubuntu:14.04 
MAINTAINER Devin Egan <docker@devinegan.com>


RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get install -y wget \
    && wget http://downloads.sourceforge.net/project/rkhunter/rkhunter/1.4.2/rkhunter-1.4.2.tar.gz \
    && wget http://downloads.sourceforge.net/project/rkhunter/rkhunter/1.4.2/rkhunter-1.4.2.tar.gz.sha256 \
    && sha256sum -c rkhunter-1.4.2.tar.gz.sha256 \
    && tar zxfv rkhunter-1.4.2.tar.gz -C /tmp \
    && cd /tmp/rkhunter-1.4.2/ \ 
    && ./installer.sh --layout /usr --install  \
    && sed 's/LOGFILE=\/var\/log\/rkhunter.log/LOGFILE=\/data\/rkhunter.log/g' /etc/rkhunter.conf > rkhunter.conf \
    && mv rkhunter.conf /etc/rkhunter.conf \
    && cat /etc/rkhunter.conf

WORKDIR /data

ENTRYPOINT ["rkhunter"]
CMD ["--help"]

