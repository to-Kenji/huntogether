#!/bin/sh
set -ex

SECURITY_GROUP_NAME="huntogether_circleci_sg"
IP=`curl -s ifconfig.me`

aws ec2 authorize-security-group-ingress --group-id ${SECURITY_GROUP_NAME} --protocol tcp --port 22 --cidr ${IP}}/32
bundle exec cap production deploy
aws ec2 revoke-security-group-ingress --group-id ${SECURITY_GROUP_NAME} --protocol tcp --port 22 --cidr ${IP}}/32