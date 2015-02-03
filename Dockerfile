FROM debian:wheezy
MAINTAINER smashwilson@gmail.com

RUN useradd hagrid

USER hagrid

ADD . /home/hagrid/
