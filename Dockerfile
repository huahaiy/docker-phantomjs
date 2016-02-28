#
# Run phantomjs for the latest Debian Stable 
#
# Version     0.2
#

FROM huahaiy/debian

MAINTAINER Huahai Yang <hyang@juji-inc.com>

RUN \
  echo "===> install dependencies..."  && \ 
  sed -i '/^deb/ s/$/ contrib/' /etc/apt/sources.list && \
  apt-get update  && \
  apt-get install -y --force-yes wget git libfreetype6 libfontconfig bzip2 && \
  \
  \
  echo "===> clean up..."  && \
  apt-get autoremove -y && \
  apt-get clean all && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN \
  cd / && \
  wget  -q --no-check-certificate https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
  tar xjvf phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
  rm /phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
  mv /phantomjs-2.1.1-linux-x86_64 /phantomjs && \
  cd /phantomjs && \
  ln -s /phantomjs/bin/phantomjs /usr/bin/phantomjs 

RUN \
  cd / && \ 
  git clone https://github.com/goodylabs/screenshot-service.git

EXPOSE 8000

WORKDIR /screenshot-service

CMD ["phantomjs","server.js"]
