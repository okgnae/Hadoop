### Default configuration files
${HADOOP_HOME}/share/doc/hadoop/hadoop-yarn/hadoop-yarn-common/yarn-default.xml
${HADOOP_HOME}/share/doc/hadoop/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml
${HADOOP_HOME}/share/doc/hadoop/hadoop-project-dist/hadoop-common/core-default.xml
${HADOOP_HOME}/share/doc/hadoop/hadoop-project-dist/hadoop-hdfs-rbf/hdfs-rbf-default.xml
${HADOOP_HOME}/share/doc/hadoop/hadoop-mapreduce-client/hadoop-mapreduce-client-core/mapred-default.xml

### Clean restart; WARNNING DATA LOSS
stop-all.sh
rm -rf  /tmp/hadoop-hadoop/*
ssh hadoop@dn1 rm -rf  /tmp/hadoop-hadoop/*
ssh hadoop@dn2 rm -rf  /tmp/hadoop-hadoop/*
hdfs namenode -format
start-all.sh

### Make a directory
hdfs dfs -mkdir /test

### Make a directory
hdfs dfs -put /etc/hosts /test

### List Storage in a directory
hdfs dfs -ls /
hdfs dfs -ls /test

### Read content of a file in hdfs
hdfs dfs -cat /test/hosts

### Browse to Hadoop web UI
http://192.168.1.121:9870/

### Browse to YARN web UI
http://192.168.1.121:8088/

### Run a MapReduse Job/Application with YARN
yarn jar /opt/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.0.jar wordcount "/test/hosts" output

### View results
hdfs dfs -cat /user/hadoop/output/part-r-00000
