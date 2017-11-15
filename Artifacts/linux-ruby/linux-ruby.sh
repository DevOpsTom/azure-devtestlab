#!/bin/bash

rubyversion=$1

sudo apt-add-repository ppa:brightbox/ruby-ng
sudo apt-get update
sudo apt-get install -y "ruby${rubyversion}" "ruby${rubyversion}-dev"