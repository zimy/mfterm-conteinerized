FROM ubuntu:xenial
RUN apt-get update
RUN apt-get -y install build-essential
RUN apt-get -y install libc6-i386 git libtool libusb-dev
RUN apt-get -y install libglib2.0-dev automake autotools-dev libusb-1.0-0* libssl-dev libncurses5 bison flex libreadline-dev

RUN git clone https://github.com/nfc-tools/libnfc.git && \
git clone https://github.com/4ZM/mfterm.git && \
git clone https://github.com/nfc-tools/mfoc.git

RUN cd /libnfc && autoreconf -vis && ./configure --with-drivers=pn532_uart && make && make install && ldconfig && \
cd /mfterm && ./autogen.sh && ./configure && make && make install && \
cd /mfoc && autoreconf -vis && ./configure && make && make install && ldconfig

WORKDIR /
ENV LIBNFC_INTRUSIVE_SCAN=true
