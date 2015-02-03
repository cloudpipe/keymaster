FROM debian:wheezy
MAINTAINER smashwilson@gmail.com

RUN useradd hagrid && \
  apt-get install openssl

USER hagrid

ADD . /home/hagrid/
