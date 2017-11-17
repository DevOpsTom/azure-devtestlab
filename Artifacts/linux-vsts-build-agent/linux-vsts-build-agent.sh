#!/bin/bash

ROOT_UID=0
if [ $UID != $ROOT_UID ]; then
    echo "You don't have sufficient privileges to run this script."
    exit 1
fi

url=$1
pool=$2
token=$3

useradd vsts-agent

INSTALL_DIR=/opt/vsts-build-agent

VSTS_AGENT_VERSION="2.124.0"
VSTS_AGENT_URL="https://github.com/Microsoft/vsts-agent/releases/download/v${VSTS_AGENT_VERSION=}/vsts-agent-ubuntu.16.04-x64-${VSTS_AGENT_VERSION=}.tar.gz"

mkdir $INSTALL_DIR
cd $INSTALL_DIR
wget $VSTS_AGENT_URL
tar zxvf vsts-agent-ubuntu.16.04-x64-${VSTS_AGENT_VERSION}.tar.gz
chown -R vsts-agent:vsts-agent $INSTALL_DIR

sudo -H -u vsts-agent bash -c "cd $INSTALL_DIR;./config.sh --unattended --url $url --auth pat --token $token --pool $pool --agent $(hostname) --acceptTeeEula" > /tmp/vsts.log
./svc.sh install &
./svc.sh start &