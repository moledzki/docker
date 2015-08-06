#!/bin/bash
set -e

POSTGRESQL_USER=${POSTGRESQL_USER:-"zosia_regresja"}
POSTGRESQL_PASS=${POSTGRESQL_PASS:-"zosia_regresja"}
POSTGRESQL_DATABASE=${POSTGRESQL_DATABASE:-"zosia_regresja"}

echo $POSTGRESQL_USER
echo $POSTGRESQL_PASS
echo "ALTER USER $POSTGRESQL_USER WITH PASSWORD '$POSTGRESQL_PASS';"

export POSTGRESQL_USER POSTGRESQL_PASS POSTGRESQL_DATABASE

POSTGRESQL_BIN=/usr/lib/postgresql/9.3/bin/postgres
POSTGRESQL_CONFIG_FILE=/etc/postgresql/9.3/main/postgresql.conf
POSTGRESQL_DATA=/var/lib/postgresql/9.3/main

rm -rf $POSTGRESQL_DATA
#if [ ! -d $POSTGRESQL_DATA ]; then
    mkdir -p $POSTGRESQL_DATA
    chown -R postgres:postgres /var/lib/postgresql
    sudo -u postgres /usr/lib/postgresql/9.3/bin/initdb -D $POSTGRESQL_DATA
    ln -s /etc/ssl/certs/ssl-cert-snakeoil.pem $POSTGRESQL_DATA/server.crt
    ln -s /etc/ssl/private/ssl-cert-snakeoil.key $POSTGRESQL_DATA/server.key

    envsubst < /usr/local/share/postgresql/create_zosia_user_database_template.sql > /usr/local/share/postgresql/create_zosia_user_database.sql
    envsubst < /usr/local/share/postgresql/prepare_database_template.sql > /usr/local/share/postgresql/prepare_database.sql
    sudo -u postgres $POSTGRESQL_BIN --single --config-file=$POSTGRESQL_CONFIG_FILE -d 2 postgres < /usr/local/share/postgresql/create_zosia_user_database.sql
    sudo -u postgres $POSTGRESQL_BIN --single --config-file=$POSTGRESQL_CONFIG_FILE -d 2 $POSTGRESQL_DATABASE < /usr/local/share/postgresql/prepare_database.sql

#sudo -u postgres $POSTGRESQL_BIN --single --config-file=$POSTGRESQL_CONFIG_FILE -d 1 postgres <<< "CREATE ROLE $POSTGRESQL_USER LOGIN PASSWORD '$POSTGRESQL_PASS' VALID UNTIL 'infinity';"
	#sudo -u postgres $POSTGRESQL_BIN --single --config-file=$POSTGRESQL_CONFIG_FILE -d 1 postgres <<< "CREATE DATABASE $POSTGRESQL_DATABASE WITH OWNER = $POSTGRESQL_USER ENCODING = 'UTF8' CONNECTION LIMIT = -1;"
	#sudo -u postgres $POSTGRESQL_BIN --single --config-file=$POSTGRESQL_CONFIG_FILE -d 1 $POSTGRESQL_DATABASE <<< "CREATE EXTENSION IF NOT EXISTS ltree SCHEMA pg_catalog VERSION '1.0';"
	#sudo -u postgres $POSTGRESQL_BIN --single --config-file=$POSTGRESQL_CONFIG_FILE -d 1 $POSTGRESQL_DATABASE <<< "CREATE EXTENSION IF NOT EXISTS pg_trgm;"
	#sudo -u postgres $POSTGRESQL_BIN --single --config-file=$POSTGRESQL_CONFIG_FILE -d 1 $POSTGRESQL_DATABASE <<< "ALTER EXTENSION pg_trgm SET SCHEMA pg_catalog;"
	#sudo -u postgres $POSTGRESQL_BIN --single --config-file=$POSTGRESQL_CONFIG_FILE -d 1 $POSTGRESQL_DATABASE <<< "ALTER SCHEMA public OWNER TO $POSTGRESQL_USER;"
#fi

exec sudo -u postgres $POSTGRESQL_BIN --config-file=$POSTGRESQL_CONFIG_FILE
