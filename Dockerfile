FROM debian:stretch

LABEL maintainer="ovsyannikov.alexey95@gmail.com"

USER root

RUN apt update && apt -y install wget gnupg2 openjdk-8-jdk zip unzip curl sudo git software-properties-common pass

RUN mkdir -p /var/jenkins_home/jenkins && cd /var/jenkins_home/ &&\
    wget http://mirrors.jenkins.io/war-stable/2.249.2/jenkins.war &&\
    chown 1000:1000 jenkins.war

RUN useradd -s /bin/bash -G sudo -d /var/jenkins_home -u 1000 jenkins && chown -R jenkins:jenkins /var/jenkins_home &&\
    chmod 777 /tmp

VOLUME /var/jenkins_home/jenkins

COPY ./run /var/jenkins_home/
RUN chown -R 1000:1000 /var/jenkins_home && chmod +x /var/jenkins_home/run

USER 1000

ENTRYPOINT /var/jenkins_home/run
