#!/bin/bash

ROOT_UID=0
if [ $UID != $ROOT_UID ]; then
    echo "You don't have sufficient privileges to run this script."
    exit 1
fi

url=$1
pool=$2
token=$3
install_user=$4

INSTALL_DIR=/opt/vsts-build-agent

vsts_agent_version="2.124.0"
vsts_agent_url="https://github.com/Microsoft/vsts-agent/releases/download/v${vsts_agent_version=}/vsts-agent-ubuntu.16.04-x64-${vsts_agent_version=}.tar.gz"

mkdir $INSTALL_DIR
cd $INSTALL_DIR
wget $vsts_agent_url
tar zxvf vsts-agent-ubuntu.16.04-x64-${vsts_agent_version}.tar.gz

sudo -H -u $install_user bash -c "./config.sh --unattended --url $url --auth pat --token $token --pool $pool --agent `hostname` --acceptTeeEula"
./svc.sh install &
./svc.sh start &