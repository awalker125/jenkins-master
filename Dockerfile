FROM jenkins/jenkins:2.141
MAINTAINER Andrew Walker <awalker125@users.noreply.github.com>

# Suppress apt installation warnings
ENV DEBIAN_FRONTEND=noninteractive

# Change to root user
USER root


ARG DOCKER_GID=1001

RUN groupadd -g ${DOCKER_GID:-1001} docker

# Used to control Docker and Docker Compose versions installed

ARG DOCKER_ENGINE=1.12.6
ARG DOCKER_COMPOSE=1.14.0
ARG ANSIBLE=2.4.0
ARG PACKER=1.0.2

# Install base packages
RUN apt-get update -y && \
    apt-get install apt-transport-https ca-certificates curl python-dev python-setuptools gcc make libssl-dev -y && \
    easy_install pip



RUN apt-key adv --keyserver-option http-proxy=${http_proxy} --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D  && \
    echo "deb https://apt.dockerproject.org/repo debian-stretch main" | tee /etc/apt/sources.list.d/docker.list && \
    apt-get update -y && \
    apt-get purge lxc-docker* -y && \
    apt-get install docker-engine=${DOCKER_ENGINE:-1.12.6}-0~debian-stretch -y && \
    usermod -aG docker jenkins && \
    usermod -aG users jenkins




# Install Docker Compose and ansible
RUN pip install docker-compose==${DOCKER_COMPOSE:-1.6.2} && \
    pip install ansible==${ANSIBLE:-2.4.0}

ENV ANSIBLE_SSH_ARGS="-C -o ControlMaster=auto -o ControlPersist=60s -o ForwardAgent=yes"

#Install packer

RUN cd /usr/local/bin && \
	curl -o /usr/local/bin/packer_${PACKER:-1.0.2}_linux_amd64.zip https://releases.hashicorp.com/packer/${PACKER:-1.0.2}/packer_${PACKER:-1.0.2}_linux_amd64.zip && \
	unzip packer_${PACKER:-1.0.2}_linux_amd64.zip && \
	chmod +x /usr/local/bin/packer && \
	rm -rf packer_${PACKER:-1.0.2}_linux_amd64.zip 

# Change to jenkins user
USER jenkins
ENV USER=jenkins

# Add Jenkins plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt


