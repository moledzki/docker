FROM moledzki/python:u22.04-p3.10.4
LABEL org.opencontainers.image.authors="Maciej Olędzki <maciej.oledzki@gmail.com>"

ARG robotVersion
ARG seleniumVersion
ARG robotSeleniumVersion
ARG robotDatabaseVersion
ARG robotImapVersion
ARG robotCSVVersion
ARG robotPDFVersion
ARG pdfplumberVersion

RUN test -n "$robotVersion" && test -n "$seleniumVersion" && test -n "$robotSeleniumVersion" && test -n "$robotDatabaseVersion" && test -n "$robotImapVersion" && test -n "$robotPDFVersion" && test -n "$pdfplumberVersion"
RUN apt-get update && apt-get install -y python3-psycopg2 curl jq && rm -rf /var/lib/apt/lists/*

#RUN pip install --upgrade --ignore-installed urllib3
#RUN python3 -m pip install --upgrade pip
RUN pip3 install robotframework==$robotVersion selenium==$seleniumVersion robotframework-seleniumlibrary==$robotSeleniumVersion robotframework-databaselibrary==$robotDatabaseVersion robotframework-imaplibrary2==$robotImapVersion robotframework-csvlibrary==$robotCSVVersion robotframework-pdf2textlibrary==$robotPDFVersion pdfplumber==$pdfplumberVersion

ADD CSVLibrary.patch /
RUN patch -p1 /usr/local/lib/python3.10/dist-packages/CSVLibrary/__init__.py /CSVLibrary.patch && rm /CSVLibrary.patch

ADD run.sh /usr/local/bin/run_tests
RUN chmod +x /usr/local/bin/run_tests

VOLUME ["/var/lib/robot/input"]
VOLUME ["/var/lib/robot/output"]

CMD ["echo",  "Należy użyć komendy run"]
