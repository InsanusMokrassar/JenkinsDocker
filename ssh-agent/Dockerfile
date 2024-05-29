FROM jenkins/ssh-agent:5.38.0-jdk17 as ssh-agent

LABEL maintainer="ovsyannikov.alexey95@gmail.com"

USER root

RUN mv /bin/sh /bin/sh.old && ln -s /bin/bash /bin/sh

ENV TZ=Etc/GMT
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt -y install wget gnupg2 zip unzip curl sudo git software-properties-common pass axel

RUN chmod 777 /tmp

#USER jenkins

RUN curl -s "https://get.sdkman.io" | bash
RUN source "$HOME/.sdkman/bin/sdkman-init.sh" &&\
    sdk install java `sdk ls java | grep librca | grep " 17" | grep -m 1 -Eo "(.?[0-9]{1,2}){3}" | head -1`-librca &&\
    sdk default java `sdk ls java | grep librca | grep " 17" | grep -m 1 -Eo "(.?[0-9]{1,2}){3}" | head -1`-librca
