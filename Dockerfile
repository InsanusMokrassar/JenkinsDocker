FROM ubuntu:20.04

LABEL maintainer="ovsyannikov.alexey95@gmail.com"

SHELL ["/bin/bash", "-c"]

USER root

ENV TZ=Etc/GMT
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN mv /bin/sh /bin/sh.old && ln -s /bin/bash /bin/sh
RUN apt update && apt -y install wget gnupg2 zip unzip curl sudo git software-properties-common pass axel

RUN mkdir -p /var/jenkins_home/jenkins && cd /var/jenkins_home/ &&\
    useradd -s /bin/bash -G sudo -d /var/jenkins_home -u 1000 jenkins &&\
    chmod 777 /tmp
COPY ./run /var/jenkins_home/
RUN chown -R jenkins:jenkins /var/jenkins_home

USER jenkins

RUN curl -s "https://get.sdkman.io" | bash
RUN source "$HOME/.sdkman/bin/sdkman-init.sh" &&\
    sdk install java `sdk ls java | grep librca | grep " 17" | grep -m 1 -Eo "(.?[0-9]{1,2}){3}" | head -1`-librca &&\
    sdk default java `sdk ls java | grep librca | grep " 17" | grep -m 1 -Eo "(.?[0-9]{1,2}){3}" | head -1`-librca

RUN cd /var/jenkins_home/ && wget http://mirrors.jenkins.io/war-stable/2.426.1/jenkins.war

ENTRYPOINT /var/jenkins_home/run
VOLUME /var/jenkins_home/jenkins
