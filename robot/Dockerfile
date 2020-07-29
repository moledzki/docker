FROM moledzki/python
MAINTAINER Maciej Olędzki <maciej.oledzki@gmail.com>

RUN apt-get update && apt-get install -y python-psycopg2 curl && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade --ignore-installed urllib3
RUN pip install robotframework==3.2.1 selenium==3.141.0 robotframework-seleniumlibrary==4.5.0 robotframework-databaselibrary==1.0.1

ADD run.sh /usr/local/bin/run_tests
RUN chmod +x /usr/local/bin/run_tests

VOLUME ["/var/lib/robot/input"]
VOLUME ["/var/lib/robot/output"]

CMD ["echo" "Use run command"]
