mcv-constructor-jenkins
=========================

This project is a jenkins master from docker.io with some extra plugins we need.

It has ansible and packer built into the image so we can build our packer/ansible projects.

In order to build this project you need a running docker host with composer installed.

## Building the project

We do not have a jenkins to start this off so it must be done manually.


	git clone git@ncl-devops-git.eu.hpecorp.net:mcv/mcv-constructor-jenkins.git
	cd mcv-constructor-jenkins
	git pull
	. ./setup_env.sh
	docker-compose build
	docker-compose up -d