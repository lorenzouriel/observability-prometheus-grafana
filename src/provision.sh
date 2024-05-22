#/bin/bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io -y # Install community version (docker-ce), command line (docker-ce-cli) and 
sudo systemctl start docker # Used to examine and control the initialization system (systemctl)
sudo systemctl enable docker