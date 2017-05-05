FROM ubuntu:xenial
RUN apt-get update
RUN apt-get -y install build-essential
RUN apt-get -y install libc6-i386 git
RUN apt-get -y install libtool libusb-dev libglib2.0-dev
RUN apt-get -y install automake autotools-dev libusb-1.0-0*
RUN apt-get -y install libssl-dev libncurses5
RUN apt-get -y install bison flex libreadline-dev
RUN git clone https://github.com/nfc-tools/libnfc.git
RUN git clone https://github.com/4ZM/mfterm.git
RUN git clone https://github.com/nfc-tools/mfoc.git
WORKDIR /libnfc
#RUN sed "s/allow_intrusive_scan = false/allow_intrusive_scan = true/" -i libnfc/nfc-internal.c
RUN autoreconf -vis && ./configure --with-drivers=pn532_uart && make && make install && ldconfig
WORKDIR /mfterm
RUN ./autogen.sh && ./configure && make && make install 
WORKDIR /mfoc
RUN autoreconf -vis && ./configure && make && make install && ldconfig
WORKDIR /
ENV LIBNFC_INTRUSIVE_SCAN=true
