FROM moledzki/python
MAINTAINER Maciej Olędzki <maciej.oledzki@gmail.com>

RUN apt-get update
RUN apt-get install -y python-psycopg2

RUN pip install robotframework robotframework-selenium2library robotframework-databaselibrary

ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

VOLUME ["/var/lib/robot/input"]
VOLUME ["/var/lib/robot/output"]

CMD ["/usr/local/bin/run.sh"]
