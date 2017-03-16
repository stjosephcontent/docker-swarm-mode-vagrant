#!/bin/bash

/vagrant/provision-base.sh
MANAGER_IP=$1
curl -sSL https://get.docker.com/ | sh
docker swarm init --listen-addr ${MANAGER_IP}:2377 --advertise-addr ${MANAGER_IP}
docker swarm join-token -q worker > /vagrant/worker_token
