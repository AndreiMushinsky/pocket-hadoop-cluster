FROM debian

MAINTAINER Andrei.Mushinsky

RUN apt-get update && apt-get install -y openjdk-7-jdk \
                                         openssh-server \
                                         wget

RUN wget http://www-eu.apache.org/dist/hadoop/common/hadoop-2.7.2/hadoop-2.7.2.tar.gz && \
    tar -xzvf hadoop-2.7.2.tar.gz && \
    mv hadoop-2.7.2 /usr/local/hadoop && \
    rm hadoop-2.7.2.tar.gz 

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV HADOOP_HOME /usr/local/hadoop
ENV PATH $JAVA_HOME/bin:$HADOOP_HOME/sbin:$HADOOP_HOME/bin:$PATH

RUN ln -s $JAVA_HOME/jre/lib/amd64/server/libjvm.so /lib/x86_64-linux-gnu/libjvm.so

RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys 

RUN mkdir -p ~/hdfs/namenode && \
    mkdir -p ~/hdfs/datanode

COPY config/* $HADOOP_HOME/etc/hadoop/

RUN mv $HADOOP_HOME/etc/hadoop/ssh_config ~/.ssh/config

RUN $HADOOP_HOME/bin/hdfs namenode -format

CMD ["sh", "-c", "service ssh start; bash"]
