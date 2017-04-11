#!/bin/bash
set -e

POSTGRESQL_USER=${DB_USER:-"pguser"}
POSTGRESQL_PASS=${DB_PASS:-"pguser"}
POSTGRESQL_DATABASE=${DB_DATABASE:-"pgdb"}
POSTGRESQL_KEEP_DB=${DB_KEEP_DB:-"no"}

#echo $POSTGRESQL_USER
#echo $POSTGRESQL_PASS
#echo "ALTER USER $POSTGRESQL_USER WITH PASSWORD '$POSTGRESQL_PASS';"

export POSTGRESQL_USER POSTGRESQL_PASS POSTGRESQL_DATABASE

POSTGRESQL_BIN=/usr/lib/postgresql/9.3/bin/postgres
POSTGRESQL_CONFIG_FILE=/etc/postgresql/9.3/main/postgresql.conf
POSTGRESQL_DATA=/var/lib/postgresql/9.3/main

if [ "$POSTGRESQL_KEEP_DB" == "no" ]; then
    echo "Postgres data directory will be deleted. Set POSTGRESQL_KEEP_DB to 'yes' to prevent this."
    rm -rf $POSTGRESQL_DATA
else 
    echo "Postgres data directory will keep intact. Set POSTGRESQL_KEEP_DB to 'no' to remove it on startup."
fi

if [ ! -d $POSTGRESQL_DATA ]; then
    mkdir -p $POSTGRESQL_DATA
    chown -R postgres:postgres /var/lib/postgresql
    sudo -u postgres /usr/lib/postgresql/9.3/bin/initdb -D $POSTGRESQL_DATA
    ln -s /etc/ssl/certs/ssl-cert-snakeoil.pem $POSTGRESQL_DATA/server.crt
    ln -s /etc/ssl/private/ssl-cert-snakeoil.key $POSTGRESQL_DATA/server.key

    envsubst < /usr/local/share/postgresql/create_user_database_template.sql > /usr/local/share/postgresql/create_user_database.sql
    envsubst < /usr/local/share/postgresql/prepare_database_template.sql > /usr/local/share/postgresql/prepare_database.sql
    sudo -u postgres $POSTGRESQL_BIN --single --config-file=$POSTGRESQL_CONFIG_FILE -d 2 postgres < /usr/local/share/postgresql/create_user_database.sql
    sudo -u postgres $POSTGRESQL_BIN --single --config-file=$POSTGRESQL_CONFIG_FILE -d 2 $POSTGRESQL_DATABASE < /usr/local/share/postgresql/prepare_database.sql
fi
exec sudo -u postgres $POSTGRESQL_BIN --config-file=$POSTGRESQL_CONFIG_FILE
