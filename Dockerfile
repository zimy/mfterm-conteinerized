FROM ubuntu:xenial
RUN apt-get update
RUN apt-get -y install git
RUN apt-get -y install build-essential
RUN apt-get -y install libc6-i386
RUN apt-get -y install libtool libusb-dev libglib2.0-dev
RUN apt-get -y install automake
RUN apt-get -y install autotools-dev libusb-1.0-0*
RUN apt-get -y install libssl-dev libncurses5
RUN apt-get -y install bison flex
RUN apt-get -y install libreadline-dev
RUN git clone https://github.com/nfc-tools/libnfc.git
RUN git clone https://github.com/4ZM/mfterm.git
WORKDIR /libnfc
RUN sed "s/allow_intrusive_scan = false/allow_intrusive_scan = true/" -i libnfc/nfc-internal.c
RUN autoreconf -vis
RUN ./configure --with-drivers=pn532_uart
RUN make
RUN make install
RUN ldconfig
WORKDIR /mfterm
RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install
WORKDIR /
