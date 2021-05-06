FROM moledzki/ubuntu
MAINTAINER Maciej Olędzki <maciej.oledzki@gmail.com>

# Python basics
RUN apt-get clean && apt-get update && apt-get install -y --fix-missing python python-pip python-setuptools && rm -rf /var/lib/apt/lists/*
RUN pip install https://files.pythonhosted.org/packages/b6/ac/7015eb97dc749283ffdec1c3a88ddb8ae03b8fad0f0e611408f196358da3/pip-9.0.1-py2.py3-none-any.whl --upgrade
#RUN easy_install -U pip==9.0.1
#RUN pip install --upgrade pip
#RUN pip install --upgrade setuptools
