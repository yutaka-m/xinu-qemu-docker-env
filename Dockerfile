From ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq
RUN apt-get install -y automake build-essential libgmp-dev libmpfr-dev libmpc-dev vim less texinfo git bison flex wget curl qemu-system-arm gawk u-boot-tools

RUN mkdir -p /opt/cross
RUN mkdir -p /build/arm-none-eabi/gcc
RUN mkdir -p /build/arm-none-eabi/binutils
RUN cd /build; wget https://ftp.gnu.org/gnu/binutils/binutils-2.21.1.tar.bz2; tar jxf binutils-2.21.1.tar.bz2; curl "http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD" -o binutils-2.21.1/config.guess
RUN cd /build/arm-none-eabi/binutils; ../../binutils-2.21.1/configure --target arm-none-eabi --prefix=/opt/cross --disable-werror && make && make install

RUN cd /build; wget https://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-4.8.1/gcc-4.8.1.tar.bz2; tar jxf gcc-4.8.1.tar.bz2
RUN cd /build/arm-none-eabi/gcc; wget http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.guess; cp config.guess ../../gcc-4.8.1/config.guess; CFLAGS='-fgnu89-inline -g -O2' CXXFLAGS='-fgnu89-inline -g -O2' ../../gcc-4.8.1/configure --target arm-none-eabi --prefix=/opt/cross  --enable-languages=c --disable-libssp && sed -i -e "/@end tex/d" ../../gcc-4.8.1/gcc/doc/gcc.texi && make && make install

ENV PATH=/opt/cross/bin:$PATH
RUN cd /build; git clone https://github.com/nao1215/LearningXinuFromSource.git
COPY Makefile /build/LearningXinuFromSource/compile/Makefile
RUN cd /build/LearningXinuFromSource/compile; make
