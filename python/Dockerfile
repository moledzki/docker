FROM moledzki/ubuntu
MAINTAINER Maciej Olędzki <maciej.oledzki@gmail.com>

COPY pip-9.0.1.tar.gz /

# Python basics
RUN apt-get clean && apt-get update && apt-get install -y --fix-missing python python-pip python-setuptools && rm -rf /var/lib/apt/lists/*
#RUN easy_install /pip-9.0.1.tar.gz
#RUN easy_install -U pip==9.0.1
#RUN pip install --upgrade pip
#RUN pip install --upgrade setuptools
