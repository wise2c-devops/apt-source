# Wise2C Apt Source for Docker/K8S/Ceph/NFS installation
Wise2C Apt Source for Docker/K8S/Ceph/NFS installation

使用方法

Apt Source服务器安装好docker，直接运行命令：

docker run -d -p 2008:2008 --name=apt-source wise2c/apt-source:v1.15.9

在需要安装docker/k8s/ceph/nfs的其它主机上：

创建一个文件 wise2c.list 并将其拷贝至 /etc/apt/sources.list.d/

Ubuntu16系统用户：

######################################################

deb http://apt-source-server-ip:2008/debs/ubuntu16 ./

######################################################

Ubuntu18系统用户：

######################################################

deb http://apt-source-server-ip:2008/debs/ubuntu18 ./

######################################################

上面的 apt-source-server-ip 请写为上述服务器的真实IP地址

然后下载Apt源的签名文件做导入：

Ubuntu16系统用户：

```
curl -o breeze.pub http://apt-source-server-ip:2008/debs/ubuntu16/breeze.pub 
apt-key add breeze.pub
```

Ubuntu18系统用户：
```
curl -o breeze.pub http://apt-source-server-ip:2008/debs/ubuntu18/breeze.pub
apt-key add breeze.pub
```

上面的 apt-source-server-ip 请写为上述服务器的真实IP地址

接着执行一次apt-get update命令后即可直接用 apt-get install命令命令安装相关软件了。例如：

apt-get install docker-ce python-docker docker-compose

apt-get install rsync python-chardet jq nfs-utils
  
apt-get install kubectl kubelet kubeadm

apt-get install ceph-deploy ceph ceph-radosgw rbd-nbd rbd-mirror
