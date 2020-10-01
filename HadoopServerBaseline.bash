### Hadoop Build Guide
# 192.168.1.121 | 10.0.0.121 | HADOOP1.hq.corp | Hadoop Name Node 1| CentOS 7
# 192.168.1.122 | 10.0.0.122 | HADOOP2.hq.corp | Hadoop Data Node 1| CentOS 7
# 192.168.1.123 | 10.0.0.123 | HADOOP3.hq.corp | Hadoop Data Node 2| CentOS 7

###############
### Hadoop1 ###
###############

hostnamectl set-hostname HADOOP1.corp.hq
sed -i 's/IPADDR=.*/IPADDR=192.168.1.121/' /etc/sysconfig/network-scripts/ifcfg-enp0s3
sed -i 's/IPADDR=.*/IPADDR=10.0.0.121/' /etc/sysconfig/network-scripts/ifcfg-enp0s8
systemctl restart network

echo '' > /etc/hosts
echo '10.0.0.121 HADOOP1.corp.hq name-node1 nn1' >> /etc/hosts
echo '10.0.0.122 HADOOP2.corp.hq data-node1 dn1' >> /etc/hosts
echo '10.0.0.123 HADOOP3.corp.hq data-node2 dn2' >> /etc/hosts

echo '' > /etc/resolv.conf
echo 'search corp.hq' >> /etc/resolv.conf
echo 'nameserver 10.0.0.11' >> /etc/resolv.conf

firewall-cmd --set-default=drop
firewall-cmd --remove-interface=enp0s3 --zone=public
firewall-cmd --remove-interface=enp0s8 --zone=public
firewall-cmd --add-interface=enp0s3 --zone=drop
firewall-cmd --add-interface=enp0s8 --zone=drop

### SSH
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" service name="ssh" accept'
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" service name="ssh" accept'

### dfs.namenode.http-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="9870" protocol="tcp" accept'
### dfs.namenode.https-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="9871" protocol="tcp" accept'

### mapreduce.jobhistory.webapp.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="19888" protocol="tcp" accept'
### mapreduce.jobhistory.webapp.https.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="19890" protocol="tcp" accept'
### mapreduce.jobhistory.admin.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="10033" protocol="tcp" accept'


### yarn.resourcemanager.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8032" protocol="tcp" accept'
### yarn.resourcemanager.scheduler.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8030" protocol="tcp" accept'
### yarn.resourcemanager.webapp.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8088" protocol="tcp" accept'
### yarn.resourcemanager.webapp.https.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8090" protocol="tcp" accept'
### yarn.nodemanager.webapp.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8042" protocol="tcp" accept'
### yarn.nodemanager.webapp.https.address 
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8044" protocol="tcp" accept'
### yarn.router.webapp.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8089" protocol="tcp" accept'
### yarn.router.webapp.https.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8091" protocol="tcp" accept'


### fs.defaultFS
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="9000" protocol="tcp" accept'
### dfs.datanode.http.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="9864" protocol="tcp" accept'
### dfs.datanode.https.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="9865" protocol="tcp" accept'
### dfs.datanode.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="9866" protocol="tcp" accept'
### dfs.datanode.ipc.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="9867" protocol="tcp" accept'
### dfs.namenode.secondary.http-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="9868" protocol="tcp" accept'
### dfs.namenode.secondary.https-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="9869" protocol="tcp" accept'
### dfs.journalnode.rpc-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8485" protocol="tcp" accept'
### dfs.journalnode.http-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8480" protocol="tcp" accept'
### dfs.journalnode.https-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8481" protocol="tcp" accept'
### dfs.provided.aliasmap.inmemory.dnrpc-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="50200" protocol="tcp" accept'


### mapreduce.jobhistory.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="10020" protocol="tcp" accept'
### yarn.resourcemanager.resource-tracker.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8031" protocol="tcp" accept'
### yarn.resourcemanager.admin.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8033" protocol="tcp" accept'
### yarn.nodemanager.localizer.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8040" protocol="tcp" accept'
### yarn.nodemanager.collector-service.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8048" protocol="tcp" accept'
### yarn.timeline-service.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="10200" protocol="tcp" accept'
### yarn.timeline-service.webapp.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8188" protocol="tcp" accept'
### yarn.timeline-service.webapp.https.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8190" protocol="tcp" accept'
### yarn.sharedcache.admin.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8047" protocol="tcp" accept'
### yarn.sharedcache.webapp.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8788" protocol="tcp" accept'
### yarn.sharedcache.uploader.server.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8046" protocol="tcp" accept'
### yarn.nodemanager.amrmproxy.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8049" protocol="tcp" accept'

firewall-cmd --reload
firewall-cmd --list-all

cat << EOF > /etc/yum.repos.d/CentOS-Local.repo
name=CentOS-Local-Base
baseurl=http://10.0.0.10/yum/centos/base/Packages
gpgcheck=0
enabled=1
[CentOS-Local-Extras]
name=CentOS-Local-Extras
baseurl=http://10.0.0.10/yum/centos/extras/Packages
gpgcheck=0
enabled=1
[CentOS-Local-Updates]
name=CentOS-Local-Updates
baseurl=http://10.0.0.10/yum/centos/updates/Packages
gpgcheck=0
enabled=1
EOF

yum update -y
yum install java -y

curl --url https://downloads.apache.org/hadoop/common/hadoop-3.3.0/hadoop-3.3.0-aarch64.tar.gz --output /tmp/hadoop-3.3.0-aarch64.tar.gz
cp /tmp/hadoop-3.3.0-aarch64.tar.gz /opt/
tar -zxf /opt/hadoop-3.3.0-aarch64.tar.gz -C /opt/
mv /opt/hadoop-3.3.0/ /opt/hadoop/

useradd -u 1001 -U hadoop -s /bin/bash -m
su - hadoop
ssh-keygen -b 2048
cat /home/hadoop/.ssh/id_rsa.pub > /home/hadoop/.ssh/authorized_keys
chmod -R 700 /home/hadoop/.ssh
scp /home/hadoop/.ssh/authorized_keys daniel@n1:/tmp
scp /home/hadoop/.ssh/authorized_keys daniel@n2:/tmp

reboot


###############
### Hadoop2 ###
###############
hostnamectl set-hostname HADOOP2.corp.hq
sed -i 's/IPADDR=.*/IPADDR=192.168.1.122/' /etc/sysconfig/network-scripts/ifcfg-enp0s3
sed -i 's/IPADDR=.*/IPADDR=10.0.0.122/' /etc/sysconfig/network-scripts/ifcfg-enp0s8
systemctl restart network

echo '' > /etc/hosts
echo '10.0.0.121 HADOOP1.corp.hq name-node1 nn1' >> /etc/hosts
echo '10.0.0.122 HADOOP2.corp.hq data-node1 dn1' >> /etc/hosts
echo '10.0.0.123 HADOOP3.corp.hq data-node2 dn2' >> /etc/hosts

echo '' > /etc/resolv.conf
echo 'search corp.hq' >> /etc/resolv.conf
echo 'nameserver 10.0.0.11' >> /etc/resolv.conf

firewall-cmd --set-default=drop
firewall-cmd --remove-interface=enp0s3 --zone=public
firewall-cmd --remove-interface=enp0s8 --zone=public
firewall-cmd --add-interface=enp0s3 --zone=drop
firewall-cmd --add-interface=enp0s8 --zone=drop

### SSH
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" service name="ssh" accept'
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" service name="ssh" accept'

### dfs.namenode.http-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="9870" protocol="tcp" accept'
### dfs.namenode.https-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="9871" protocol="tcp" accept'

### mapreduce.jobhistory.webapp.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="19888" protocol="tcp" accept'
### mapreduce.jobhistory.webapp.https.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="19890" protocol="tcp" accept'
### mapreduce.jobhistory.admin.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="10033" protocol="tcp" accept'


### yarn.resourcemanager.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8032" protocol="tcp" accept'
### yarn.resourcemanager.scheduler.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8030" protocol="tcp" accept'
### yarn.resourcemanager.webapp.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8088" protocol="tcp" accept'
### yarn.resourcemanager.webapp.https.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8090" protocol="tcp" accept'
### yarn.nodemanager.webapp.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8042" protocol="tcp" accept'
### yarn.nodemanager.webapp.https.address 
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8044" protocol="tcp" accept'
### yarn.router.webapp.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8089" protocol="tcp" accept'
### yarn.router.webapp.https.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8091" protocol="tcp" accept'


### fs.defaultFS
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="9000" protocol="tcp" accept'
### dfs.datanode.http.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="9864" protocol="tcp" accept'
### dfs.datanode.https.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="9865" protocol="tcp" accept'
### dfs.datanode.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="9866" protocol="tcp" accept'
### dfs.datanode.ipc.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="9867" protocol="tcp" accept'
### dfs.namenode.secondary.http-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="9868" protocol="tcp" accept'
### dfs.namenode.secondary.https-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="9869" protocol="tcp" accept'
### dfs.journalnode.rpc-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8485" protocol="tcp" accept'
### dfs.journalnode.http-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8480" protocol="tcp" accept'
### dfs.journalnode.https-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8481" protocol="tcp" accept'
### dfs.provided.aliasmap.inmemory.dnrpc-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="50200" protocol="tcp" accept'


### mapreduce.jobhistory.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="10020" protocol="tcp" accept'
### yarn.resourcemanager.resource-tracker.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8031" protocol="tcp" accept'
### yarn.resourcemanager.admin.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8033" protocol="tcp" accept'
### yarn.nodemanager.localizer.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8040" protocol="tcp" accept'
### yarn.nodemanager.collector-service.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8048" protocol="tcp" accept'
### yarn.timeline-service.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="10200" protocol="tcp" accept'
### yarn.timeline-service.webapp.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8188" protocol="tcp" accept'
### yarn.timeline-service.webapp.https.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8190" protocol="tcp" accept'
### yarn.sharedcache.admin.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8047" protocol="tcp" accept'
### yarn.sharedcache.webapp.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8788" protocol="tcp" accept'
### yarn.sharedcache.uploader.server.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8046" protocol="tcp" accept'
### yarn.nodemanager.amrmproxy.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8049" protocol="tcp" accept'

firewall-cmd --reload
firewall-cmd --list-all

cat << EOF > /etc/yum.repos.d/CentOS-Local.repo
name=CentOS-Local-Base
baseurl=http://10.0.0.10/yum/centos/base/Packages
gpgcheck=0
enabled=1
[CentOS-Local-Extras]
name=CentOS-Local-Extras
baseurl=http://10.0.0.10/yum/centos/extras/Packages
gpgcheck=0
enabled=1
[CentOS-Local-Updates]
name=CentOS-Local-Updates
baseurl=http://10.0.0.10/yum/centos/updates/Packages
gpgcheck=0
enabled=1
EOF

yum update -y
yum install java -y

curl --url https://downloads.apache.org/hadoop/common/hadoop-3.3.0/hadoop-3.3.0-aarch64.tar.gz --output /tmp/hadoop-3.3.0-aarch64.tar.gz
cp /tmp/hadoop-3.3.0-aarch64.tar.gz /opt/
tar -zxf /opt/hadoop-3.3.0-aarch64.tar.gz -C /opt/
mv /opt/hadoop-3.3.0/ /opt/hadoop/

useradd -u 1001 -U hadoop -s /bin/bash -m
su - hadoop
mkdir /home/hadoop/.ssh
cp /tmp/authorized_keys /home/hadoop/.ssh/authorized_keys
chmod -R 700 /home/hadoop/.ssh

reboot


###############
### Hadoop3 ###
###############
hostnamectl set-hostname HADOOP3.corp.hq
sed -i 's/IPADDR=.*/IPADDR=192.168.1.123/' /etc/sysconfig/network-scripts/ifcfg-enp0s3
sed -i 's/IPADDR=.*/IPADDR=10.0.0.123/' /etc/sysconfig/network-scripts/ifcfg-enp0s8
systemctl restart network

echo '' > /etc/hosts
echo '10.0.0.121 HADOOP1.corp.hq name-node1 nn1' >> /etc/hosts
echo '10.0.0.122 HADOOP2.corp.hq data-node1 dn1' >> /etc/hosts
echo '10.0.0.123 HADOOP3.corp.hq data-node2 dn2' >> /etc/hosts

echo '' > /etc/resolv.conf
echo 'search corp.hq' >> /etc/resolv.conf
echo 'nameserver 10.0.0.11' >> /etc/resolv.conf

firewall-cmd --set-default=drop
firewall-cmd --remove-interface=enp0s3 --zone=public
firewall-cmd --remove-interface=enp0s8 --zone=public
firewall-cmd --add-interface=enp0s3 --zone=drop
firewall-cmd --add-interface=enp0s8 --zone=drop

### SSH
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" service name="ssh" accept'
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" service name="ssh" accept'

### dfs.namenode.http-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="9870" protocol="tcp" accept'
### dfs.namenode.https-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="9871" protocol="tcp" accept'

### mapreduce.jobhistory.webapp.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="19888" protocol="tcp" accept'
### mapreduce.jobhistory.webapp.https.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="19890" protocol="tcp" accept'
### mapreduce.jobhistory.admin.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="10033" protocol="tcp" accept'


### yarn.resourcemanager.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8032" protocol="tcp" accept'
### yarn.resourcemanager.scheduler.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8030" protocol="tcp" accept'
### yarn.resourcemanager.webapp.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8088" protocol="tcp" accept'
### yarn.resourcemanager.webapp.https.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8090" protocol="tcp" accept'
### yarn.nodemanager.webapp.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8042" protocol="tcp" accept'
### yarn.nodemanager.webapp.https.address 
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8044" protocol="tcp" accept'
### yarn.router.webapp.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8089" protocol="tcp" accept'
### yarn.router.webapp.https.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" port port="8091" protocol="tcp" accept'


### fs.defaultFS
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="9000" protocol="tcp" accept'
### dfs.datanode.http.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="9864" protocol="tcp" accept'
### dfs.datanode.https.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="9865" protocol="tcp" accept'
### dfs.datanode.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="9866" protocol="tcp" accept'
### dfs.datanode.ipc.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="9867" protocol="tcp" accept'
### dfs.namenode.secondary.http-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="9868" protocol="tcp" accept'
### dfs.namenode.secondary.https-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="9869" protocol="tcp" accept'
### dfs.journalnode.rpc-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8485" protocol="tcp" accept'
### dfs.journalnode.http-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8480" protocol="tcp" accept'
### dfs.journalnode.https-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8481" protocol="tcp" accept'
### dfs.provided.aliasmap.inmemory.dnrpc-address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="50200" protocol="tcp" accept'


### mapreduce.jobhistory.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="10020" protocol="tcp" accept'
### yarn.resourcemanager.resource-tracker.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8031" protocol="tcp" accept'
### yarn.resourcemanager.admin.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8033" protocol="tcp" accept'
### yarn.nodemanager.localizer.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8040" protocol="tcp" accept'
### yarn.nodemanager.collector-service.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8048" protocol="tcp" accept'
### yarn.timeline-service.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="10200" protocol="tcp" accept'
### yarn.timeline-service.webapp.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8188" protocol="tcp" accept'
### yarn.timeline-service.webapp.https.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8190" protocol="tcp" accept'
### yarn.sharedcache.admin.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8047" protocol="tcp" accept'
### yarn.sharedcache.webapp.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8788" protocol="tcp" accept'
### yarn.sharedcache.uploader.server.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8046" protocol="tcp" accept'
### yarn.nodemanager.amrmproxy.address
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="10.0.0.120/29" port port="8049" protocol="tcp" accept'

firewall-cmd --reload
firewall-cmd --list-all

cat << EOF > /etc/yum.repos.d/CentOS-Local.repo
name=CentOS-Local-Base
baseurl=http://10.0.0.10/yum/centos/base/Packages
gpgcheck=0
enabled=1
[CentOS-Local-Extras]
name=CentOS-Local-Extras
baseurl=http://10.0.0.10/yum/centos/extras/Packages
gpgcheck=0
enabled=1
[CentOS-Local-Updates]
name=CentOS-Local-Updates
baseurl=http://10.0.0.10/yum/centos/updates/Packages
gpgcheck=0
enabled=1
EOF

yum update -y
yum install java -y

curl --url https://downloads.apache.org/hadoop/common/hadoop-3.3.0/hadoop-3.3.0-aarch64.tar.gz --output /tmp/hadoop-3.3.0-aarch64.tar.gz
cp /tmp/hadoop-3.3.0-aarch64.tar.gz /opt/
tar -zxf /opt/hadoop-3.3.0-aarch64.tar.gz -C /opt/
mv /opt/hadoop-3.3.0/ /opt/hadoop/

useradd -u 1001 -U hadoop -s /bin/bash -m
su - hadoop
mkdir /home/hadoop/.ssh
cp /tmp/authorized_keys /home/hadoop/.ssh/authorized_keys
chmod -R 700 /home/hadoop/.ssh

reboot
