FROM ubuntu:14.04
MAINTAINER docrystal.org <info@docrystal.org>

ENV SHARDS_VERSION 0.5.3

RUN apt-get update && \
      apt-get install -y \
      build-essential \
      curl \
      git \
      gzip \
      libbsd-dev \
      libedit-dev \
      libevent-core-2.0-5 \
      libevent-dev \
      libevent-extra-2.0-5 \
      libevent-openssl-2.0-5 \
      libevent-pthreads-2.0-5 \
      libgc-dev \
      libgmp-dev \
      libgmpxx4ldbl \
      libpcl1-dev \
      libreadline-dev \
      libssl-dev \
      libxml2-dev \
      libyaml-dev \
      tar

RUN git clone https://github.com/manastech/crystal.git /usr/src/crystal/crystal-head && \
      cd /usr/src/crystal/crystal-head && \
      make crystal && \
      ln -s /usr/src/crystal/crystal-head/bin/crystal /usr/local/bin/crystal

RUN curl -L -o /tmp/shards-${SHARDS_VERSION}.gz https://github.com/ysbaddaden/shards/releases/download/v${SHARDS_VERSION}/shards-${SHARDS_VERSION}_linux_x86_64.gz && \
  mkdir -p /usr/src/shards && \
  gzip -c -d /tmp/shards-${SHARDS_VERSION}.gz > /usr/src/shards/shards-${SHARDS_VERSION} && \
  chmod +x /usr/src/shards/shards-${SHARDS_VERSION} && \
  rm /tmp/shards-${SHARDS_VERSION}.gz && \
  ln -s /usr/src/shards/shards-${SHARDS_VERSION} /usr/local/bin/shards

CMD [ "/bin/bash" ]
