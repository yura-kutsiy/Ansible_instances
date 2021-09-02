#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt install -y ansible
sudo apt install tree -y
sudo apt install stress -y

rm /home/ubuntu/.ssh/keys/master.pem
mv /home/ubuntu/.ssh/keys/* /home/ubuntu/.ssh/
sudo chmod 400 /home/ubuntu/.ssh/client-*
rm -r /home/ubuntu/.ssh/keys

cd /home/ubuntu/ ;
git clone https://github.com/yura-kutsiy/ansible_l-11 ;
mv ansible_l-11 ansible ;
rm -r -f ansible/.git ;
rm ansible/README.md
cd
chown ubuntu:ubuntu ansible/ ; chown ubuntu:ubuntu ansible/*
