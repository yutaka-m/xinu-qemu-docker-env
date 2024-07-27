From ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq
RUN apt-get install -y automake build-essential libgmp-dev libmpfr-dev libmpc-dev vim less texinfo git bison flex wget curl qemu-system-mips 

RUN mkdir -p /opt/cross
RUN mkdir -p /build/mipsel/gcc
RUN mkdir -p /build/mipsel/binutils
RUN cd /build; wget https://ftp.gnu.org/gnu/binutils/binutils-2.21.1.tar.bz2; tar jxf binutils-2.21.1.tar.bz2; curl "http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD" -o binutils-2.21.1/config.guess
RUN cd /build/mipsel/binutils; ../../binutils-2.21.1/configure --target mipsel --prefix=/opt/cross --disable-werror && make && make install

RUN cd /build; wget https://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-4.2.0/gcc-4.2.0.tar.bz2; tar jxf gcc-4.2.0.tar.bz2
RUN cd /build/mipsel/gcc; wget http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.guess; cp config.guess ../../gcc-4.2.0/config.guess; CFLAGS='-fgnu89-inline -g -O2' CXXFLAGS='-fgnu89-inline -g -O2' ../../gcc-4.2.0/configure --target mipsel --prefix=/opt/cross  --enable-languages=c --disable-libssp && make && make install
RUN ls -la /opt/cross/bin/
COPY mipsVars /tmp/
RUN cd /build; export PATH=/opt/cross/bin:$PATH; ls -la /opt/cross/bin/; git clone https://github.com/xinu-os/xinu.git; cd xinu/compile; cp /tmp/mipsVars ./; make PLATFORM=mipsel-qemu


