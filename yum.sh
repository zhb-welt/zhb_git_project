#!/bin/bash
[ $USER == root ] && echo "yum配置中" || exit
mkdir /etc/yum.repos.d/repo &> /dev/null
mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/repo &> /dev/null
[ -e /mnt  ] && [ -e /dev/cdrom ] && mount /dev/cdrom /mnt &> /dev/null
echo "[centos]
name=centos7
baseurl=file:///mnt
enbaled=1
gpgcheck=0" > /etc/yum.repos.d/centos.repo
yum clean all &> /dev/null
sleep 1
yum repolist
echo "yum离线配置成功"


echo 正在进行网络yum配置
echo nameserver 8.8.8.8 > /etc/resolv.conf
ping -c 4 -i 0.2 -W 1 www.baidu.com
[ ! $? -eq 0 ] && echo "请检查网络配置是否正确" && exit

wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
[ $? -eq 0 ] && echo "yum网络配置成功" || echo "yum网络配置失败"
