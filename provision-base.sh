#!/bin/bash

apt-get update -y
apt-get install -y python-pip
pip install --upgrade pip
pip install --upgrade docker-compose
groupadd --system docker
usermod -a -G docker ubuntu
ln -s /vagrant /home/ubuntu/vagrant

