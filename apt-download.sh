#!/bin/bash
current_path=`pwd`
rm -rf /tmp/debs
mkdir -p /tmp/debs
cd /tmp/debs

apt-get install --assume-no $1 > apt-get-install.log
first_line=`grep -n "The following additional packages will be installed:" apt-get-install.log |awk -F":" '{print $1}'`
first_line=$[first_line+1]
last_line=`grep -n "Suggested packages:" apt-get-install.log |awk -F":" '{print $1}'`
last_line=$[last_line-1]
sed -n "${first_line},${last_line} p" apt-get-install.log > download.log

first_line=`grep -n "The following NEW packages will be installed:" apt-get-install.log |awk -F":" '{print $1}'`
first_line=$[first_line+1]
last_line=`grep -n "The following packages will be upgraded:" apt-get-install.log |awk -F":" '{print $1}'`
if [ -z "$last_line" ]; then
  last_line=`grep -n " newly installed, " apt-get-install.log |awk -F":" '{print $1}'`
fi
last_line=$[last_line-1]
sed -n "${first_line},${last_line} p" apt-get-install.log >> download.log

deb_packages=`cat download.log`

# remove the "|" string in the content
#deb_packages=${deb_packages//|/}

echo "##### Download packages for $1 #####"
echo "##### apt-get install return message begin #####"
cat apt-get-install.log |grep -v 'Abort.'
echo "##### apt-get install return message end #####"
echo "##### The following packages will be download #####"
echo ${deb_packages}
apt-get download ${deb_packages}
echo "###### Downloading finished #####"
rm -f apt-get-install.log download.log

cd ${current_path}
