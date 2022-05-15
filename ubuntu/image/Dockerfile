#FROM ubuntu:22.10
FROM ubuntu:20.04
MAINTAINER Maciej Olędzki <maciej.oledzki@gmail.com>

ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --fix-missing wget ca-certificates gettext-base locales && rm -rf /var/lib/apt/lists/*

# Set locale
RUN locale-gen --no-purge en_US.UTF-8
