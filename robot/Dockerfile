FROM moledzki/python
MAINTAINER Maciej Olędzki <maciej.oledzki@gmail.com>

RUN apt-get update && apt-get install -y python-psycopg2

RUN pip install robotframework robotframework-selenium2library robotframework-databaselibrary

ADD run.sh /usr/local/bin/run_tests
RUN chmod +x /usr/local/bin/run_tests

VOLUME ["/var/lib/robot/input"]
VOLUME ["/var/lib/robot/output"]

CMD ["echo" "Use run command"]
