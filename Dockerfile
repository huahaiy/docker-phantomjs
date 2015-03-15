#
# Run phantomjs for the latest Debian Stable 
#
# Version     0.1
#

  #fallocate -l 4G /swapfile && \
  #chmod 600 /swapfile && \ 
  #mkswap /swapfile && \
  #swapon /swapfile && \

FROM huahaiy/debian

MAINTAINER Huahai Yang <hyang@juji-inc.com>

RUN \
  echo "===> install dependencies..."  && \ 
  sed -i '/^deb/ s/$/ contrib/' /etc/apt/sources.list && \
  apt-get update  && \
  apt-get install -y --force-yes build-essential g++ flex bison gperf ruby \
    perl libsqlite3-dev libfontconfig1-dev libicu-dev libfreetype6 libssl-dev \
    libpng-dev libjpeg-dev git ttf-mscorefonts-installer python && \
  \
  \
  echo "===> build "  && \
  git clone git://github.com/ariya/phantomjs.git && \
  cd phantomjs && \
  git checkout 2.0 && \
  yes | ./build.sh && \
  \
  \
  echo "===> clean up..."  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

