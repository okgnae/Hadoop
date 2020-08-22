### Hadoop Server Baseline
# 192.168.1.121 | 10.0.0.121 | HADOOP1.hq.corp | Hadoop | CentOS 7
# 192.168.1.122 | 10.0.0.122 | HADOOP2.hq.corp | Hadoop | CentOS 7
# 192.168.1.123 | 10.0.0.123 | HADOOP3.hq.corp | Hadoop | CentOS 7

###############
### Hadoop1 ###
###############

hostnamectl set-hostname HADOOP1.corp.hq
sed -i 's/IPADDR=.*/IPADDR=192.168.1.121/' /etc/sysconfig/network-scripts/ifcfg-enp0s3
sed -i 's/IPADDR=.*/IPADDR=10.0.0.121/' /etc/sysconfig/network-scripts/ifcfg-enp0s8
systemctl restart network

echo 'HADOOP1.corp.hq  10.0.0.121' >> /etc/hosts
echo 'HADOOP2.corp.hq  10.0.0.122' >> /etc/hosts
echo 'HADOOP3.corp.hq  10.0.0.123' >> /etc/hosts
echo 'nameserver 10.0.0.11' >> /etc/resolv.conf

yum install java -y



###############
### Hadoop2 ###
###############
hostnamectl set-hostname HADOOP2.corp.hq
sed -i 's/IPADDR=.*/IPADDR=192.168.1.122/' /etc/sysconfig/network-scripts/ifcfg-enp0s3
sed -i 's/IPADDR=.*/IPADDR=10.0.0.122/' /etc/sysconfig/network-scripts/ifcfg-enp0s8
systemctl restart network

echo 'HADOOP1.corp.hq  10.0.0.121' >> /etc/hosts
echo 'HADOOP2.corp.hq  10.0.0.122' >> /etc/hosts
echo 'HADOOP3.corp.hq  10.0.0.123' >> /etc/hosts
echo 'nameserver 10.0.0.11' >> /etc/resolv.conf

yum install java -y

###############
### Hadoop3 ###
###############
hostnamectl set-hostname HADOOP3.corp.hq
sed -i 's/IPADDR=.*/IPADDR=192.168.1.123/' /etc/sysconfig/network-scripts/ifcfg-enp0s3
sed -i 's/IPADDR=.*/IPADDR=10.0.0.123/' /etc/sysconfig/network-scripts/ifcfg-enp0s8
systemctl restart network

echo 'HADOOP1.corp.hq  10.0.0.121' >> /etc/hosts
echo 'HADOOP2.corp.hq  10.0.0.122' >> /etc/hosts
echo 'HADOOP3.corp.hq  10.0.0.123' >> /etc/hosts
echo 'nameserver 10.0.0.11' >> /etc/resolv.conf

yum install java -y
