#!/usr/bin/env bash

# Add sources for jenkins to APT
sudo wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo echo "deb http://pkg.jenkins-ci.org/debian binary/" >> /etc/apt/sources.list

# Basic stuff
apt-get update
apt-get install -y apache2 default-jdk maven jenkins git unzip

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

# Install Artifactory
pushd /opt
sudo wget -O artifactory-3.5.1.zip http://bit.ly/Hqv9aj
sudo unzip artifactory-3.5.1.zip
sudo rm -f artifactory-3.5.1.zip
sudo ln -s `ls -1d artifactory-*` artifactory
sudo artifactory-3.5.1/bin/installService.sh
sudo cp /vagrant/artifactory_server.xml /opt/artifactory/tomcat/conf/server.xml
sudo service artifactory start
popd


# Install Nexus
pushd /usr/local
sudo wget -q -O nexus-latest-bundle.tar.gz http://www.sonatype.org/downloads/nexus-latest-bundle.tar.gz
sudo tar xzf nexus-latest-bundle.tar.gz
sudo rm -f nexus-latest-bundle.tar.gz
sudo ln -s `ls -1d nexus-*` nexus
sudo cp /vagrant/nexus /etc/init.d/nexus
sudo chown root /etc/init.d/nexus
sudo chmod 755 /etc/init.d/nexus
pushd /etc/init.d
sudo update-rc.d nexus defaults
sudo service nexus start
popd
popd

# Generate key pair to be used by git
mkdir -p /vagrant/keys
pushd /vagrant/keys
ssh-keygen -t rsa -C "omegapoint" -q -f id_rsa -N ''
popd

# Set up git server
sudo adduser --disabled-password --gecos "" git
sudo su git
cd /home/git
mkdir .ssh && chmod 700 .ssh
touch .ssh/authorized_keys && chmod 600 .ssh/authorized_keys
cat /vagrant/keys/id_rsa.pub >> ~/.ssh/authorized_keys
mkdir cicd_repo.git
cd cicd_repo.git
git init --bare
exit

# Set environment variables
sudo cp /vagrant/environment /etc/environment