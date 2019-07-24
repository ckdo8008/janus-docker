FROM ubuntu:18.04
LABEL maintainer="Rafael Ingaramo (rafael.ingaramo@hotmail.com)" 
RUN apt update && apt install -y \
  git \
  libmicrohttpd-dev \
  libjansson-dev \
  libssl-dev \
  libsrtp-dev \
  libsofia-sip-ua-dev \
  libglib2.0-dev \
  libopus-dev \ 
  libogg-dev \ 
  libcurl4-openssl-dev \
  liblua5.3-dev \
  libconfig-dev \
  pkg-config \
  gengetopt \
  libtool \
  automake \
  gtk-doc-tools \
  nginx \
  wget

RUN git clone https://gitlab.freedesktop.org/libnice/libnice
WORKDIR /libnice
RUN sh ./autogen.sh
RUN sh ./configure --prefix=/usr
RUN make && make install

WORKDIR /
RUN wget https://github.com/cisco/libsrtp/archive/v2.2.0.tar.gz
RUN tar xfv v2.2.0.tar.gz
WORKDIR /libsrtp-2.2.0
RUN sh ./configure --prefix=/usr --enable-openssl
RUN make shared_library && make install

WORKDIR /
RUN git clone https://github.com/meetecho/janus-gateway.git
WORKDIR /janus-gateway
RUN sh ./autogen.sh
RUN sh ./configure --prefix=/opt/janus
RUN make && make install
RUN make configs

COPY janus.transport.http.jcfg /opt/janus/etc/janus/.
COPY localhost.crt /etc/ssl/.
COPY localhost.key /etc/ssl/.
COPY nginx.conf /etc/nginx/.

ENTRYPOINT service nginx restart && /opt/janus/bin/janus