#!/usr/bin/env bash

# Basic stuff
apt-get update
apt-get install -y default-jdk git unzip jetty8


# Install Oracle Java 7 and 8
# (thanks to https://gist.github.com/tinkerware/cf0c47bb69bf42c2d740)
apt-get -y -q update
apt-get -y -q upgrade
apt-get -y -q install software-properties-common htop
add-apt-repository ppa:webupd8team/java
apt-get -y -q update
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
apt-get -y -q install oracle-java8-installer
apt-get -y -q install oracle-java7-installer
update-java-alternatives -s java-8-oracle


# Set environment variables
sudo cp /vagrant/environment_run /etc/environment