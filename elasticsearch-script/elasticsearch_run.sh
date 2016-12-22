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
pg_name=elasticsearch

prgStart(){
  echo -n "Starting $pg_name : "
  daemon $ES_HOME/bin/elasticsearch -d -Des.pidfile=${ES_HOME}/elasticsearch.pid \
                           -Des.default.path.home=${ES_HOME} \
                           -Des.default.path.logs=${LOG_DIR} \
                           -Des.default.path.data=${DATA_DIR} \
                           -Des.default.path.conf=${CONF_DIR}
  RETVAL=$?
  echo
  [ $RETVAL -eq 0 ]
  return $retval
}

prgStop(){
  echo -n "Stoping $pg_name : "
  killproc -p ${ES_HOME}/elasticsearch.pid
  RETVAL=$?
  echo
  [ $RETVAL -eq 0 ]
  return $retval
}

case "$1" in
 start)
   prgStart
   #RETVAL=$?
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
 echo