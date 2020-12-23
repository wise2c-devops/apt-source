#!/bin/bash
current_path=`pwd`
rm -rf /tmp/debs
mkdir -p /tmp/debs
cd /tmp/debs

echo "##### Install packages $1 to generate version list #####"
apt-get install -y $1 > apt-get-install.log

echo "##### The following packages will be download #####"
cat apt-get-install.log |grep Unpack |awk '{print $2"="$3}' |awk -F'(' '{print $1$2}' |awk -F')' '{print $1}'

echo "##### Download packages for $1 #####"
for package in `cat apt-get-install.log |grep Unpack |awk '{print $2"="$3}' |awk -F'(' '{print $1$2}' |awk -F')' '{print $1}'`
do
  apt-get download $package ;
done

echo "###### Downloading finished #####"
rm -f apt-get-install.log

echo ${current_path}
cd ${current_path}
