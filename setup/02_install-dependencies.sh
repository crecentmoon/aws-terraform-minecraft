cd /storage | sudo mkdir setup | sudo chmod 777 setup

# then copy this file under /storage/setup/02_install-dependencies.sh

sudo yum -y update

sudo rpm --import https://yum.corretto.aws/corretto.key

sudo curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo

sudo yum install -y java-18-amazon-corretto-devel git