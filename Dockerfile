FROM debian:sid-slim
MAINTAINER Manu Sanchez <Manu343726@gmail.com>

RUN apt update -y && apt install -y git build-essential
RUN apt install -y libdw-dev libpython2.7-dev libncursesw5-dev libcapstone-dev pkg-config

ARG UFTRACE_VERSION=master
RUN git clone https://github.com/namhyung/uftrace --branch=$UFTRACE_VERSION
WORKDIR uftrace
RUN ./configure
RUN make -j$(nproc --all)
RUN make install
RUN cd .. && rm -rf uftrace
WORKDIR /
USER 1000:1000
ENTRYPOINT ["/usr/local/bin/uftrace"]
