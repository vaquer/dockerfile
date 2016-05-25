#!/bin/sh

# Adjust config file
sed -i -e "s|#solr_url = http://127.0.0.1:8983/solr|solr_url = http://$SOLR_PORT_8983_TCP_ADDR:$SOLR_PORT_8983_TCP_PORT/solr|" /project/development.ini
sed -i -e "s|ckan.site_url =|ckan.site_url = http://localhost|" /project/development.ini
sed -i -e "s|ckan_default:pass@localhost/ckan_default|$POSTGRES_ENV_POSTGRES_USER:$POSTGRES_ENV_POSTGRES_PASSWORD@$POSTGRES_PORT_5432_TCP_ADDR/$POSTGRES_ENV_POSTGRES_USER|" /project/development.ini
sed -i -e "s|datastore_default:pass@localhost/datastore_default|$POSTGRES_ENV_POSTUSER_DATASTORE:$POSTGRES_ENV_POSTPWD_DATASTORE@$POSTGRES_PORT_5432_TCP_ADDR/$POSTGRES_ENV_POSTUSER_DATASTORE|" /project/development.ini

# Create tables
if [ "$INIT_DBS" = true ]; then
  echo "Configurando la DB"
  $CKAN_HOME/bin/paster --plugin=ckan db init -c /project/development.ini
  $CKAN_HOME/bin/paster --plugin=ckan datastore set-permissions -c /project/development.ini | ssh $POSTGRES_PORT_5432_TCP_ADDR sudo -u postgres psql --username $POSTGRES_USER --set ON_ERROR_STOP=1
  $CKAN_HOME/bin/paster --plugin=ckanext-spatial spatial initdb 4326 -c /project/development.ini
fi


$CKAN_HOME/bin/paster --plugin=ckan create-test-data -c /project/development.ini

# Crea datos de prueba
if [ "$TEST_DATA" = true]; then
  echo "Llenando datos de prueba"
  $CKAN_HOME/bin/paster --plugin=ckan create-test-data -c /project/development.ini echo "Llenando datos de prueba"
fi


# Serve site
exec apachectl -DFOREGROUND

