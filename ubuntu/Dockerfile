FROM ubuntu:14.04
MAINTAINER Maciej Olędzki <maciej.oledzki@gmail.com>

# Set locale
RUN locale-gen --no-purge en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update

RUN apt-get install -y wget ca-certificates gettext-base
