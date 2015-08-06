FROM maciek/ubuntu
MAINTAINER Maciej Olędzki <maciej.oledzki@gmail.com>

RUN sudo apt-get install -y postgresql-9.3 postgresql-contrib-9.3 sudo gettext-base

RUN mkdir /etc/ssl/private-copy; mv /etc/ssl/private/* /etc/ssl/private-copy/; rm -r /etc/ssl/private; mv /etc/ssl/private-copy /etc/ssl/private; chmod -R 0700 /etc/ssl/private; chown -R postgres /etc/ssl/private

ADD postgresql.conf /etc/postgresql/9.3/main/postgresql.conf
ADD pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf
ADD run.sh /usr/local/bin/run.sh
ADD create_zosia_user_database_template.sql /usr/local/share/postgresql/create_zosia_user_database_template.sql
ADD prepare_database_template.sql /usr/local/share/postgresql/prepare_database_template.sql
RUN chmod +x /usr/local/bin/run.sh


VOLUME ["/var/lib/postgresql"]

EXPOSE 5432
CMD ["/usr/local/bin/run.sh"]