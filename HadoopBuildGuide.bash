### Hadoop Build Guide
# 192.168.1.121 | 10.0.0.121 | HADOOP1.hq.corp | Hadoop Master Node 1| CentOS 7
# 192.168.1.122 | 10.0.0.122 | HADOOP2.hq.corp | Hadoop Node 1| CentOS 7
# 192.168.1.123 | 10.0.0.123 | HADOOP3.hq.corp | Hadoop Node 2| CentOS 7

###############
### Hadoop1 ###
###############
useradd -u 1001 -U hadoop -s /bin/bash -m
su - hadoop
ssh-keygen -b 2048
cat /home/hadoop/.ssh/id_rsa.pub > /home/hadoop/.ssh/authorized_keys
scp /home/hadoop/.ssh/authorized_keys daniel@n1:/tmp
scp /home/hadoop/.ssh/authorized_keys daniel@n2:/tmp

###################
### Hadoop2 & 3 ###
###################
useradd -u 1001 -U hadoop -s /bin/bash -m
su - hadoop
mkdir /home/hadoop/.ssh
cp /tmp/authorized_keys /home/hadoop/.ssh/authorized_keys
chmod -R 700 /home/hadoop/.ssh



