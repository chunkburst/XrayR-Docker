#!/bin/bash

# 首段代码判断摘取自 XrayR一键脚本 - XrayR-project

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

cur_dir=$(pwd)

[[ $EUID -ne 0 ]] && echo -e "${red}错误：${plain} 必须使用root用户运行此脚本！\n" && exit 1

if [[ -f /etc/redhat-release ]]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
else
    echo -e "${red}未检测到系统版本，请联系脚本作者！${plain}\n" && exit 1
fi

arch=$(arch)

if [[ $arch == "x86_64" || $arch == "x64" || $arch == "amd64" ]]; then
    arch="64"
elif [[ $arch == "aarch64" || $arch == "arm64" ]]; then
    arch="arm64-v8a"
elif [[ $arch == "s390x" ]]; then
    arch="s390x"
else
    arch="64"
    echo -e "${red}检测架构失败，使用默认架构: ${arch}${plain}"
fi

if [ "$(getconf WORD_BIT)" != '32' ] && [ "$(getconf LONG_BIT)" != '64' ] ; then
    echo "本软件不支持 32 位系统(x86)，请使用 64 位系统(x86_64)，如果检测有误，请联系作者"
    exit 2
fi

if [[ x"${release}" == x"centos" ]]; then
    yum install epel-release -y
    yum install unzip wget -y
else
    apt update -y
    apt install wget unzip -y
fi

cd /root/
mkdir Xray
cd Xray
echo -e "${green}Install：${plain} 开始下载XrayR程序！\n"
wget -q -N --no-check-certificate https://raw.githubusercontent.com/chunkburst/XrayR-Docker/main/src/XrayR-linux-64-0.9.4.zip -O Xray.zip
echo -e "${green}Install：${plain} 下载完成！开始解压\n"
unzip Xray.zip
rm -f Xray.zip
cd ..
#生成守护进程
wget -q -N --no-check-certificate https://raw.githubusercontent.com/chunkburst/XrayR-Docker/main/src/run.sh -O run.sh
chmod +x run.sh
chmod +x Xray/XrayR
bash run.sh
