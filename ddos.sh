#!/usr/bin/env bash

# Add the code to Vagrantfile
# config.vm.provision :shell, path: "ddos.sh"


echo " Upgdate & Upgrade System "
# change source mirror
mv /etc/apt/sources.list /etc/apt/sources.list.bak
cp /vagrant/sources.list /etc/apt/

apt-get update -y
apt-get upgrade -y

echo " Install python3 "
#安装编译环境
sudo apt install -y wget build-essential libreadline-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev
wget https://www.python.org/ftp/python/3.8.6/Python-3.8.6.tgz --no-check-certificate # 用命令行下载python安装包
tar -xvzf Python-3.8.6.tgz
cd Python-3.8.6
./configure --enable-optimizations  #配置编译参数
make  # 编译
sudo make install  #编译安装



echo " Install RYU "

sudo apt-get update
sudo apt-get install python3-pip    # 安装pip
sudo apt-get install python3-pip
git clone git://github.com/osrg/ryu.git  # 下载ryu源码
cd ryu
sudo pip3 install -r tools/pip-requires  #安装RYU依赖环境
python3 setup.py install   #安装RYU

echo " Install Mininet and OVS "
git clone https://github.com/mininet/mininet.git
cd mininet/
cd util/
sudo ./ install.sh -n3V 2.5.0
sudo apt-get install openvswitch-switch
echo " Install docker"
sudo apt-get update
sudo apt-get install \                           #安装软件包以允许apt通过HTTPS使用存储库
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-commoncurl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - #添加Docker的官方GPG密钥
sudo apt-key fingerprint 0EBFCD88  #  9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88通过搜索指纹的后8个字符，验证您现在是否拥有带有指纹的密钥

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   (lsb_release -cs) \
   stable"
# 使用以上命令来设置稳定的存储库。要添加 夜间或测试存储库，请在以下命令中的单词后面添加nightly或test（或两者）stable
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io  #更新apt程序包索引，并安装最新版本的Docker Engine和容器

echo " Install tcpreplay "

   git clone   https://github.com/appneta/tcpreplay/releases/download/v4.4.1/tcpreplay-4.4.1.tar.xz
   tar xzvf tcpreplay-4.4.1.tar.xz
    cd tcpreplay-4.4.1

    ./configure
   make
   sudo make install

   sudo apt-get install build-essential libpcap-dev   #  安装libpcap
   ./configure
make
sudo make install
