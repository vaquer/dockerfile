#!/bin/sh

# Adjust config file
sed -i -e "s|#solr_url = http://127.0.0.1:8983/solr|solr_url = http://$SOLR_PORT_8983_TCP_ADDR:$SOLR_PORT_8983_TCP_PORT/solr|" /project/development.ini
sed -i -e "s|ckan.site_url =|ckan.site_url = http://localhost|" /project/development.ini
sed -i -e "s|ckan_default:pass@localhost/ckan_default|$POSTGRES_ENV_POSTGRES_USER:$POSTGRES_ENV_POSTGRES_PASSWORD@$POSTGRES_PORT_5432_TCP_ADDR/$POSTGRES_ENV_POSTGRES_DB|" /project/development.ini
sed -i -e "s|datastore_default:pass@localhost/datastore_default|$POSTGRES_ENV_USER_DATASTORE:$POSTGRES_ENV_POSTGRES_PASSWORD@$POSTGRES_PORT_5432_TCP_ADDR/$POSTGRES_ENV_USER_DATASTORE|" /project/development.ini
sed -i -e "s|hostname:port:database:username:password|$POSTGRES_PORT_5432_TCP_ADDR:5432:$POSTGRES_ENV_POSTGRES_DB:$POSTGRES_ENV_POSTGRES_USER:$POSTGRES_ENV_POSTGRES_PASSWORD|" /root/.pgpass

# Create tables
if [ "$INIT_DBS" = true ]; then
  $CKAN_HOME/bin/paster --plugin=ckan db init -c /project/development.ini
  $CKAN_HOME/bin/paster --plugin=ckan datastore set-permissions -c /project/development.ini | ssh $POSTGRES_PORT_5432_TCP_ADDR sudo -u postgres psql --username $POSTGRES_ENV_POSTGRES_USER --set ON_ERROR_STOP=1
  $CKAN_HOME/bin/paster --plugin=ckanext-spatial spatial initdb 4326 -c /project/development.ini
fi

# Load a dump file to ckan database
if [ "$LOAD_DUMP" == true]; then
  $CKAN_HOME/bin/paster db load -c /project/development.ini $PATH_DUMP_SQL
fi

# Create test data for development purpose
if [ "$TEST_DATA" = true]; then
  $CKAN_HOME/bin/paster --plugin=ckan create-test-data -c /project/development.ini echo "Llenando datos de prueba"
fi

# Serve site
exec apachectl -DFOREGROUND

