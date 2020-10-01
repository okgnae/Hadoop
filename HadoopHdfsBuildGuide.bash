### Hadoop Build Guide
# 192.168.1.121 | 10.0.0.121 | HADOOP1.hq.corp | Hadoop Name Node 1| CentOS 7
# 192.168.1.122 | 10.0.0.122 | HADOOP2.hq.corp | Hadoop Data Node 1| CentOS 7
# 192.168.1.123 | 10.0.0.123 | HADOOP3.hq.corp | Hadoop Data Node 2| CentOS 7

###############
### Hadoop1 ###
###############
su - hadoop


### PATH
sed -i 's,PATH=.*,PATH=$PATH:/opt/hadoop/bin:/opt/hadoop/sbin,g' /home/hadoop/.bash_profile
ssh hadoop@dn1 sed -i 's,PATH=.*,PATH=\$PATH:/opt/hadoop/bin:/opt/hadoop/sbin,g' /home/hadoop/.bash_profile
ssh hadoop@dn2 sed -i 's,PATH=.*,PATH=\$PATH:/opt/hadoop/bin:/opt/hadoop/sbin,g' /home/hadoop/.bash_profile


### JAVA_HOME
echo "JAVA_HOME=/etc/alternatives/jre" >> /home/hadoop/.bash_profile
echo "export JAVA_HOME" >> /home/hadoop/.bash_profile
ssh hadoop@dn1 "echo 'JAVA_HOME=/etc/alternatives/jre' >> /home/hadoop/.bash_profile"
ssh hadoop@dn1 "echo 'export JAVA_HOME' >> /home/hadoop/.bash_profile"
ssh hadoop@dn2 "echo 'JAVA_HOME=/etc/alternatives/jre' >> /home/hadoop/.bash_profile"
ssh hadoop@dn2 "echo 'export JAVA_HOME' >> /home/hadoop/.bash_profile"


### hadoop-env.sh
sed -i 's,.*export JAVA_HOME=.*,export JAVA_HOME=/etc/alternatives/jre,g' /opt/hadoop/etc/hadoop/hadoop-env.sh
ssh hadoop@dn1 "sed -i 's,.*export JAVA_HOME=.*,export JAVA_HOME=/etc/alternatives/jre,g' /opt/hadoop/etc/hadoop/hadoop-env.sh"
ssh hadoop@dn2 "sed -i 's,.*export JAVA_HOME=.*,export JAVA_HOME=/etc/alternatives/jre,g' /opt/hadoop/etc/hadoop/hadoop-env.sh"


### core-site.xml
cat << EOF > /opt/hadoop/etc/hadoop/core-site.xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://name-node1:9000</value>
    </property>
</configuration>
EOF

scp /opt/hadoop/etc/hadoop/core-site.xml hadoop@dn1:/opt/hadoop/etc/hadoop/core-site.xml
scp /opt/hadoop/etc/hadoop/core-site.xml hadoop@dn2:/opt/hadoop/etc/hadoop/core-site.xml


### mkdir data
mkdir /opt/hadoop/data/
mkdir /opt/hadoop/data/nameNode/
mkdir /opt/hadoop/data/dataNode/

ssh hadoop@dn1 mkdir /opt/hadoop/data/
ssh hadoop@dn1 mkdir /opt/hadoop/data/nameNode/
ssh hadoop@dn1 mkdir /opt/hadoop/data/dataNode/

ssh hadoop@dn2 mkdir /opt/hadoop/data/
ssh hadoop@dn2 mkdir /opt/hadoop/data/nameNode/
ssh hadoop@dn2 mkdir /opt/hadoop/data/dataNode/


### hdfs-site.xml
cat << EOF > /opt/hadoop/etc/hadoop/hdfs-site.xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
            <name>dfs.namenode.name.dir</name>
            <value>/opt/hadoop/data/nameNode</value>
    </property>
    <property>
            <name>dfs.datanode.data.dir</name>
            <value>/opt/hadoop/data/dataNode</value>
    </property>
    <property>
            <name>dfs.replication</name>
            <value>2</value>
    </property>
</configuration>
EOF

scp /opt/hadoop/etc/hadoop/hdfs-site.xml hadoop@dn1:/opt/hadoop/etc/hadoop/hdfs-site.xml
scp /opt/hadoop/etc/hadoop/hdfs-site.xml hadoop@dn2:/opt/hadoop/etc/hadoop/hdfs-site.xml


### workers
cat << EOF > /opt/hadoop/etc/hadoop/workers
data-node1
data-node2
EOF

scp /opt/hadoop/etc/hadoop/workers hadoop@dn1:/opt/hadoop/etc/hadoop/workers
scp /opt/hadoop/etc/hadoop/workers hadoop@dn2:/opt/hadoop/etc/hadoop/workers


### memory settings in yarn-site.xml
cat << EOF > /opt/hadoop/etc/hadoop/yarn-site.xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
        <name>yarn.nodemanager.resource.memory-mb</name>
        <value>1536</value>
    </property>
    <property>
        <name>yarn.scheduler.maximum-allocation-mb</name>
        <value>1536</value>
    </property>
    <property>
        <name>yarn.scheduler.minimum-allocation-mb</name>
        <value>128</value>
    </property>
    <property>
        <name>yarn.nodemanager.vmem-check-enabled</name>
        <value>false</value>
    </property>
    <property>
        <name>yarn.acl.enable</name>
        <value>0</value>
    </property>
    <property>
        <name>yarn.resourcemanager.hostname</name>
        <value>name-node1</value>
    </property>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
</configuration>
EOF

scp /opt/hadoop/etc/hadoop/yarn-site.xml hadoop@dn1:/opt/hadoop/etc/hadoop/yarn-site.xml
scp /opt/hadoop/etc/hadoop/yarn-site.xml hadoop@dn2:/opt/hadoop/etc/hadoop/yarn-site.xml


### mapred-site.xml
cat << EOF > /opt/hadoop/etc/hadoop/mapred-site.xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
        <name>yarn.app.mapreduce.am.resource.mb</name>
        <value>512</value>
    </property>
    <property>
        <name>mapreduce.map.memory.mb</name>
        <value>256</value>
    </property>
    <property>
        <name>mapreduce.reduce.memory.mb</name>
        <value>256</value>
    </property>
</configuration>
EOF

scp /opt/hadoop/etc/hadoop/mapred-site.xml hadoop@dn1:/opt/hadoop/etc/hadoop/mapred-site.xml
scp /opt/hadoop/etc/hadoop/mapred-site.xml hadoop@dn2:/opt/hadoop/etc/hadoop/mapred-site.xml


### Format HDFS
hdfs namenode -format


### 
start-all.sh


###
stop-all.sh

