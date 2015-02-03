FROM debian:wheezy
MAINTAINER smashwilson@gmail.com

RUN useradd hagrid && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -q -y openssl

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/hagrid/

ADD . /home/hagrid/
RUN chown -R hagrid:hagrid /home/hagrid

USER hagrid
WORKDIR /home/hagrid/

CMD ["usage"]
