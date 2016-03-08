#!/bin/sh

# Start zookeeper
service zookeeper start

# Adjust memory parameters
sed -i -e "s|DRILL_MAX_DIRECT_MEMORY=\"8G\"|DRILL_MAX_DIRECT_MEMORY=\"$DRILL_MAX_MEMORY\"|" /apache-drill/conf/drill-env.sh
sed -i -e "s|DRILL_HEAP=\"4G\"|DRILL_HEAP=\"$DRILL_HEAP\"|" /apache-drill/conf/drill-env.sh

# Datasources config storage
echo drill.exec.sys.store.provider.local.path = "/apache-drill/sources" >> /apache-drill/conf/drill-override.conf

# Enable linked mongo by default, if any
if [ -n ${MONGO_PORT_27017_TCP_ADDR} ]; then
  echo '{
    "storage": {
      mongo : {
        "type" : "mongo",
        "connection" : "mongodb://'$MONGO_PORT_27017_TCP_ADDR:$MONGO_PORT_27017_TCP_PORT/'",
        "enabled" : true
      }
    }
  }' > /apache-drill/conf/bootstrap-storage-plugins.json
fi

# Start as foreground process
exec /apache-drill/bin/runbit
