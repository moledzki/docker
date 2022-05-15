#FROM moledzki/ubuntu:14.04.5
FROM moledzki/ubuntu:20.04-1
MAINTAINER Maciej Olędzki <maciej.oledzki@gmail.com>

RUN locale-gen en_GB && locale-gen en_GB.UTF-8 && update-locale

# Install key
RUN apt-get update && apt-get install -y gnupg && rm -rf /var/lib/apt/lists/*

RUN wget --no-check-certificate --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
# Adding 14.04 repo for postgresql 9.5
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ focal-pgdg main" >> /etc/apt/sources.list.d/postgresql.list'

RUN apt-get update && apt-get install -y postgresql-9.5 postgresql-contrib-9.5 gettext-base && rm -rf /var/lib/apt/lists/*

RUN mkdir /etc/ssl/private-copy; mv /etc/ssl/private/* /etc/ssl/private-copy/; rm -r /etc/ssl/private; mv /etc/ssl/private-copy /etc/ssl/private; chmod -R 0700 /etc/ssl/private; chown -R postgres /etc/ssl/private

ADD postgresql.conf /etc/postgresql/9.5/main/postgresql.conf
ADD pg_hba.conf /etc/postgresql/9.5/main/pg_hba.conf
ADD run.sh /usr/local/bin/run.sh
ADD create_user_database_template.sql /usr/local/share/postgresql/create_user_database_template.sql
ADD prepare_database_template.sql /usr/local/share/postgresql/prepare_database_template.sql
RUN chmod +x /usr/local/bin/run.sh
RUN rm -rf /var/lib/postgresql
#RUN touch /var/tmp/db_not_ready

#VOLUME ["/var/lib/postgresql"]

EXPOSE 5432
CMD ["/usr/local/bin/run.sh"]
