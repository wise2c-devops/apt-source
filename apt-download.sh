#!/bin/bash
current_path=`pwd`
rm -rf /tmp/debs
mkdir -p /tmp/debs
cd /tmp/debs

apt-get install --assume-no $1 > dependance.log
first_line=`grep -n "The following additional packages will be installed:" dependance.log |awk -F":" '{print $1}'`
first_line=$[first_line+1]
last_line=`grep -n "Suggested packages:" dependance.log |awk -F":" '{print $1}'`
last_line=$[last_line-1]
sed -n "${first_line},${last_line} p" dependance.log > download.log
echo "##### Download packages for $1 #####"
echo "##### dependance.log begin #####"
cat dependance.log |grep -v 'Abort.'
echo "##### dependance.log done #####"
echo "##### The following packages will be download #####"
cat download.log
apt-get download `cat download.log`
echo "###### Downloading finished #####"
rm -f dependance.log download.log

cd ${current_path}
