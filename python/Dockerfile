FROM moledzki/ubuntu
MAINTAINER Maciej Olędzki <maciej.oledzki@gmail.com>

COPY pip-9.0.1-py2.py3-none-any.whl /

# Python basics
RUN apt-get clean && apt-get update && apt-get install -y --fix-missing python python-pip python-setuptools && rm -rf /var/lib/apt/lists/*
RUN pip install --upgrade /pip-9.0.1-py2.py3-none-any.whl
#RUN easy_install -U pip==9.0.1
#RUN pip install --upgrade pip
#RUN pip install --upgrade setuptools
