#!/bin/bash

/vagrant/provision-base.sh
MANAGER_IP=$1
NODE_IP=$2
TOKEN=`cat /vagrant/worker_token`
curl -sSL https://get.docker.com/ | sh
docker swarm join --listen-addr ${NODE_IP}:2377 --advertise-addr ${NODE_IP} --token=$TOKEN ${MANAGER_IP}:2377
