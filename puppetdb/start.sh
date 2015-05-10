#!/bin/sh
set -x

#  -c ${CONFIG}
ARGS="
  -cp /usr/share/puppetdb/puppetdb.jar
  clojure.main
  -m com.puppetlabs.puppetdb.core
  services
  --chuid puppetdb
  -XX:OnOutOfMemoryError='kill -9 %p'
  -Xms=192m
  -Xmx=512m
  ${JAVA_ARGS}
"
exec /usr/bin/java $ARGS 2>&1
