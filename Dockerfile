FROM ubuntu:20.04

LABEL maintainer="ovsyannikov.alexey95@gmail.com"

USER root

ENV TZ=Etc/GMT
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt -y install wget gnupg2 openjdk-11-jdk zip unzip curl sudo git software-properties-common pass axel

RUN mkdir -p /var/jenkins_home/jenkins && cd /var/jenkins_home/ &&\
    useradd -s /bin/bash -G sudo -d /var/jenkins_home -u 1000 jenkins &&\
    chmod 777 /tmp

ENTRYPOINT /var/jenkins_home/run
COPY ./run /var/jenkins_home/
RUN chown -R jenkins:jenkins /var/jenkins_home

USER 1000

VOLUME /var/jenkins_home/jenkins

RUN cd /var/jenkins_home/ && axel -a -n 8 --max-redirect=256 http://mirrors.jenkins.io/war-stable/2.387.1/jenkins.war
