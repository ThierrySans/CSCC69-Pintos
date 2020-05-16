FROM ubuntu:18.04
MAINTAINER Thierry Sans <thierry.sans@utoronto.ca>

RUN apt-get update && apt-get -y install bash git build-essential gdb gcc emacs vim nano qemu wget xorg-dev libncursesw5 libncurses5-dev

RUN apt-get clean autoclean && rm -rf /var/lib/apt/* /var/lib/cache/* /var/lib/log/*

RUN git clone https://github.com/ThierrySans/CSCC69-Pintos /pintos

ENV PINTOS_HOME=/pintos
ENV PATH=/pintos/src/utils:$PATH

WORKDIR /pintos

RUN cd /pintos/src/misc && \
    wget --no-check-certificate https://sourceforge.net/projects/bochs/files/bochs/2.6.2/bochs-2.6.2.tar.gz && \
    env SRCDIR=/pintos/src/misc PINTOSDIR=/pintos DSTDIR=/usr/local sh ./bochs-2.6.2-build.sh && \
    rm -f bochs-2.6.2.tar.gz

RUN cd /pintos/src/utils && make

RUN cd /pintos/src/threads && make

CMD ["pintos"]


