FROM moledzki/python
MAINTAINER Maciej Olędzki <maciej.oledzki@gmail.com>

RUN apt-get update && apt-get install -y python3-psycopg2 curl jq && rm -rf /var/lib/apt/lists/*

#RUN pip install --upgrade --ignore-installed urllib3
RUN pip3 install robotframework==3.2.1 selenium==3.141.0 robotframework-seleniumlibrary==5.1.3 robotframework-databaselibrary==1.0.1 robotframework-imaplibrary2==0.4.0

ADD run.sh /usr/local/bin/run_tests
RUN chmod +x /usr/local/bin/run_tests

VOLUME ["/var/lib/robot/input"]
VOLUME ["/var/lib/robot/output"]

CMD ["echo" "Use run command"]

