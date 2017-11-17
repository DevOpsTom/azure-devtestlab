#!/bin/bash

url=$1
pool=$2
token=$3

vsts_agent_version="2.124.0"
vsts_agent_url="https://github.com/Microsoft/vsts-agent/releases/download/v${vsts_agent_version=}/vsts-agent-ubuntu.16.04-x64-${vsts_agent_version=}.tar.gz"

mkdir ~/myagent
cd myagent
wget $vsts_agent_url
tar zxvf vsts-agent-ubuntu.16.04-x64-${vsts_agent_version}.tar.gz

./config.sh --unattended --url $url --auth pat --token $token --pool $pool --agent `hostname` --acceptTeeEula
sudo ./svc.sh install
sudo ./svc.sh start