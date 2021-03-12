FROM ubuntu:20.04

LABEL maintainer="ovsyannikov.alexey95@gmail.com"

USER root

ENV TZ=Etc/GMT
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt -y install wget gnupg2 openjdk-8-jdk zip unzip curl sudo git software-properties-common pass

RUN mkdir -p /var/jenkins_home/jenkins && cd /var/jenkins_home/ &&\
    useradd -s /bin/bash -G sudo -d /var/jenkins_home -u 1000 jenkins &&\
    chown -R jenkins:jenkins /var/jenkins_home &&\
    chmod 777 /tmp
RUN wget http://mirrors.jenkins.io/war-stable/2.277.1/jenkins.war &&\
    chown 1000:1000 jenkins.war && mv jenkins.war /var/jenkins_home/

VOLUME /var/jenkins_home/jenkins

COPY ./run /var/jenkins_home/
RUN chown -R 1000:1000 /var/jenkins_home && chmod +x /var/jenkins_home/run

USER 1000

ENTRYPOINT /var/jenkins_home/run
