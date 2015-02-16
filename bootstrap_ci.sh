#!/usr/bin/env bash

# Add sources for jenkins to APT
sudo wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo echo "deb http://pkg.jenkins-ci.org/debian binary/" >> /etc/apt/sources.list

# Basic stuff
apt-get update
apt-get install -y apache2 jenkins git unzip

# Install Artifactory
#sudo cp /vagrant/artifactory-3.5.1.zip /opt
pushd /opt
sudo wget -q -O artifactory-3.5.1.zip http://bit.ly/Hqv9aj
sudo unzip artifactory-3.5.1.zip
sudo artifactory-3.5.1/bin/installService.sh
sudo service artifactory start
popd


# Install Nexus
pushd /usr/local
sudo wget -q -O nexus-latest-bundle.tar.gz http://www.sonatype.org/downloads/nexus-latest-bundle.tar.gz
sudo tar xvzf nexus-latest-bundle.tar.gz



popd