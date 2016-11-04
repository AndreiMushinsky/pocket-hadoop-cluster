#!/bin/bash

NODE_COUNT=${1:-3}

docker rm -f hadoop-master &> /dev/null
echo "About to start hadoop-master container"
docker run -itd --net=hadoop-net \
           -p 50070:50070 \
           -p 8088:8088 \
              --name hadoop-master \
              --hostname hadoop-master \
              amushinsky/hadoop && echo "Hadoop-muster started successfully"

for (( i=1; i<NODE_COUNT; i++ ))
do
  docker rm -f hadoop-slave-$i &> /dev/null
  echo "About to start hadoop-slave-$i container"
  docker run -itd --net hadoop-net \
             --name hadoop-slave-$i \
             --hostname hadoop-slave-$i \
             amushinsky/hadoop && echo "Hadoop-slave-$i started successfully"
done

docker exec hadoop-master /bin/sh -c "start-dfs.sh && start-yarn.sh" && \
  echo "Hadoop cluster started successfully"
