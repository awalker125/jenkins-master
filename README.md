jenkins-master
=========================

This project is a jenkins master from docker.io with some extra plugins we need.

It has ansible and packer built into the image so we can build our packer/ansible projects.

In order to build this project you need a running docker host with composer installed.

## install vm in azure

```bash
yum install docker
systemctl enable docker
systemctl start docker
yum -y install git
yum -y install python-pip

pip install docker-compose==1.19.0



```

## letencrypt

```bash

sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install python2-certbot-nginx
sudo certbot certonly  -d jenkins.aw125.co.uk --manual --preferred-challenges dns




```