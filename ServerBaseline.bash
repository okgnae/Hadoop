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

firewall-cmd --set-default=drop
firewall-cmd --remove-interface=enp0s3 --zone=public
firewall-cmd --remove-interface=enp0s8 --zone=public
firewall-cmd --add-interface=enp0s3 --zone=drop
firewall-cmd --add-interface=enp0s8 --zone=drop
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" service name="ssh" accept'
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


useradd -u 990 -M -U hadoop -s /sbin/nologin

cp /tmp/hadoop-3.3.0-aarch64.tar.gz /opt/

tar -zxf /opt/hadoop-3.3.0-aarch64.tar.gz -C /opt/

mv /opt/hadoop-3.3.0/ /opt/hadoop/

sed -i 's/^# export JAVA_HOME=/export JAVA_HOME=\//' /opt/hadoop/etc/hadoop/hadoop-env.sh

cat << EOF > /etc/profile.d/hadoopEnv.sh
HADOOP_HOME=/opt/hadoop
export HADOOP_HOME
export PATH=\${PATH}:\${HADOOP_HOME}/bin
EOF

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

firewall-cmd --set-default=drop
firewall-cmd --remove-interface=enp0s3 --zone=public
firewall-cmd --remove-interface=enp0s8 --zone=public
firewall-cmd --add-interface=enp0s3 --zone=drop
firewall-cmd --add-interface=enp0s8 --zone=drop
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" service name="ssh" accept'
firewall-cmd --reload
firewall-cmd --list-all

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

yum update -y
yum install java -y

curl --url https://downloads.apache.org/hadoop/common/hadoop-3.3.0/hadoop-3.3.0-aarch64.tar.gz --output /tmp/hadoop-3.3.0-aarch64.tar.gz


useradd -u 990 -M -U hadoop -s /sbin/nologin

cp /tmp/hadoop-3.3.0-aarch64.tar.gz /opt/

tar -zxf /opt/hadoop-3.3.0-aarch64.tar.gz -C /opt/

mv /opt/hadoop-3.3.0/ /opt/hadoop/

sed -i 's/^# export JAVA_HOME=/export JAVA_HOME=\//' /opt/hadoop/etc/hadoop/hadoop-env.sh

cat << EOF > /etc/profile.d/hadoopEnv.sh
HADOOP_HOME=/opt/hadoop
export HADOOP_HOME
export PATH=\${PATH}:\${HADOOP_HOME}/bin
EOF

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

firewall-cmd --set-default=drop
firewall-cmd --remove-interface=enp0s3 --zone=public
firewall-cmd --remove-interface=enp0s8 --zone=public
firewall-cmd --add-interface=enp0s3 --zone=drop
firewall-cmd --add-interface=enp0s8 --zone=drop
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.1.180" service name="ssh" accept'
firewall-cmd --reload
firewall-cmd --list-all

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

yum update -y
yum install java -y

curl --url https://downloads.apache.org/hadoop/common/hadoop-3.3.0/hadoop-3.3.0-aarch64.tar.gz --output /tmp/hadoop-3.3.0-aarch64.tar.gz


useradd -u 990 -M -U hadoop -s /sbin/nologin

cp /tmp/hadoop-3.3.0-aarch64.tar.gz /opt/

tar -zxf /opt/hadoop-3.3.0-aarch64.tar.gz -C /opt/

mv /opt/hadoop-3.3.0/ /opt/hadoop/

sed -i 's/^# export JAVA_HOME=/export JAVA_HOME=\//' /opt/hadoop/etc/hadoop/hadoop-env.sh

cat << EOF > /etc/profile.d/hadoopEnv.sh
HADOOP_HOME=/opt/hadoop
export HADOOP_HOME
export PATH=\${PATH}:\${HADOOP_HOME}/bin
EOF
