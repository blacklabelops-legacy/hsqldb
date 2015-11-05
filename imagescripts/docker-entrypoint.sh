#!/bin/bash -x
set -o errexit

if [ "$1" = 'hsqldb' ]; then
  java -Dfile.encoding=UTF-8 ${java_vm_parameters} -cp /opt/hsqldb/hsqldb-${HSQLDB_VERSION}.jar org.hsqldb.Server -database.0 file:/opt/database/hsqldb -dbname.0 xdb
fi

exec "$@"
