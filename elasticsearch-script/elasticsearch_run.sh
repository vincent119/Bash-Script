#!/bin/sh
. /etc/init.d/functions
############################################
#
#   Craeted Dtae 20161221
#   Script by Vincent yu
#
#
#
#   
###########################################

export JAVA_HOME=/opt/APP/jdk1.8.0_102

ES_USER=elasticsearch
ES_GROUP=elasticsearch
ES_HOME=/opt/APP/elasticsearch
CONF_DIR=$ES_HOME/config
DATA_DIR=$ES_HOME/data
LOG_DIR=/opt/logs/elasticsearch


prgStart(){

daemon $ES_HOME/bin/elasticsearch -d -Des.pidfile=${ES_HOME}/elasticsearch.pid \
                           -Des.default.path.home=${ES_HOME} \
                           -Des.default.path.logs=${LOG_DIR} \
                           -Des.default.path.data=${DATA_DIR} \
                           -Des.default.path.conf=${CONF_DIR}
}

prgStop(){
  killproc -p ${ES_HOME}/elasticsearch.pid

}


case "$1" in
 start)
   prgStart
   exit 0;
 ;;
 stop)
   prgStop
   exit 0
 ;;
 restart)
   prgStop
   sleep 1
   prgStart
 ;;
 status)
   status -p ${ES_HOME}/elasticsearch.pid
 ;;
 *)
 echo "usage: $0 {start|stop|restart|status}"
esac