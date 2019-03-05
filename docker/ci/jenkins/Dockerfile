FROM jenkins/jenkins:lts
MAINTAINER "Jeonhwan <demoprogrammer@gmail.com>"

USER root
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

# install basic libs
RUN apt-get update \
        && apt-get install -y sudo \
        && apt-get install -y vim \
        && apt-get install -y wget \
        && apt-get install -y git \
        && apt-get install -y rsync \
#        && apt-get install -y timedatectl \
        && rm -rf /var/lib/apt/lists/*

ENV TZ=Asia/Seoul

# timezone set
#RUN timedatectl set-timezone Asia/Seoul

# get maven 3.5.4
RUN wget --no-verbose -O /tmp/apache-maven-3.5.4-bin.tar.gz http://www-eu.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz

# install maven
RUN tar xzf /tmp/apache-maven-3.5.4-bin.tar.gz -C /opt/
RUN ln -s /opt/apache-maven-3.5.4 /opt/maven
RUN ln -s /opt/maven/bin/mvn /usr/local/bin
RUN rm -f /tmp/apache-maven-3.5.4-bin.tar.gz
ENV MAVEN_HOME /opt/maven

RUN chown -R jenkins:jenkins /opt/maven


# Volume
VOLUME /root/.ssh

# directory preparing
RUN mkdir -p /server/projects/web/bin
RUN mkdir -p /server/projects/web/lib
RUN mkdir -p /server/projects/web/logs
RUN chown -R jenkins:jenkins /server

# copy .ssh/config to temp directory
COPY ./.ssh/config /tmp/.ssh/config
RUN chown -R jenkins:jenkins /tmp/.ssh/config

# sudo setting
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
USER jenkins

# Start it all something changed I changed something
COPY init.sh /usr/local/bin/init.sh

USER root
RUN chmod +x /usr/local/bin/init.sh

USER jenkins
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/init.sh"]