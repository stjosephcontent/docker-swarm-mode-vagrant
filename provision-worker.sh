#!/bin/bash

#USE_ALIYUN_MIRROR=1

/vagrant/provision-base.sh

MANAGER_IP=$1
NODE_IP=$2
TOKEN=`cat /vagrant/worker_token`

if ! which docker >/dev/null 2>&1; then
	if [ -n "$USE_ALIYUN_MIRROR" ]
	then
		sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list
		curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -
		echo DOCKER_OPTS="'--registry-mirror https://6udu7vtl.mirror.aliyuncs.com'" > /etc/default/docker
		sudo service docker restart
	else
		curl -sSL https://get.docker.com/ | sh
	fi
	gpasswd -a vagrant docker
	docker swarm join --listen-addr ${NODE_IP}:2377 --advertise-addr ${NODE_IP} --token=$TOKEN ${MANAGER_IP}:2377
fi
