FROM moledzki/ubuntu:22.04-1
MAINTAINER Maciej Olędzki <maciej.oledzki@gmail.com>

#COPY pip-9.0.1.tar.gz /

# Python basics
RUN apt-get clean && apt-get update && apt-get install -y --fix-missing python3 python3-pip python3-setuptools && rm -rf /var/lib/apt/lists/*
#RUN easy_install /pip-9.0.1.tar.gz
#RUN easy_install -U pip==9.0.1
#RUN pip install --upgrade pip
#RUN pip install --upgrade setuptools
