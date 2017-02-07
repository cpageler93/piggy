FROM ubuntu:14.04

RUN apt-get -y update && apt-get -y upgrade && apt-get -y install wget g++ bzip2 make m4 xz-utils libssl-dev libexpat1-dev

RUN mkdir /download && cd /download

RUN wget "http://pkgconfig.freedesktop.org/releases/pkg-config-0.29.1.tar.gz" --output-document=pkg-config-0.29.1.tar.gz
RUN tar -xvzf pkg-config-0.29.1.tar.gz
RUN cd pkg-config-0.29.1
RUN ./configure  --with-internal-glib
RUN make
RUN make install
RUN cd ..

RUN wget "https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.26.tar.bz2" --output-document=libgpg-error-1.26.tar.bz2
RUN bzip2 -dk libgpg-error-1.26.tar.bz2
RUN tar -xvf libgpg-error-1.26.tar
RUN cd libgpg-error-1.26
RUN ./configure
RUN make
RUN make install
RUN cd ..

RUN wget "https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.7.6.tar.bz2" --output-document=libgcrypt-1.7.6.tar.bz2
RUN bzip2 -dk libgcrypt-1.7.6.tar.bz2
RUN tar -xvf libgcrypt-1.7.6.tar
RUN cd libgcrypt-1.7.6
RUN ./configure
RUN make
RUN make install
RUN cd ..

RUN wget "https://gmplib.org/download/gmp/gmp-6.1.2.tar.xz" --output-document=gmp-6.1.2.tar.xz
RUN tar --xz -xvf gmp-6.1.2.tar.xz
RUN cd gmp-6.1.2
RUN ./configure
RUN make
RUN make install
RUN cd ..

RUN wget "https://ftp.gnu.org/gnu/nettle/nettle-3.3.tar.gz" --output-document=nettle-3.3.tar.gz
RUN tar -xvzf nettle-3.3.tar.gz
RUN cd nettle-3.3
RUN ./configure
RUN make
RUN make install
RUN cd ..

RUN wget "https://www.unbound.net/downloads/unbound-1.6.0.tar.gz" --output-document=unbound-1.6.0.tar.gz
RUN tar -xvzf unbound-1.6.0.tar.gz
RUN cd unbound-1.6.0
RUN ./configure
RUN make
RUN make install
RUN cd ..

RUN wget "ftp://ftp.gnutls.org/gcrypt/gnutls/v3.5/gnutls-3.5.6.tar.xz" --output-document=gnutls-3.5.tar.xz
RUN tar --xz -xvf gnutls-3.5.tar.xz
RUN cd gnutls-3.5.6
RUN ./configure --with-included-libtasn1 --without-p11-kit
RUN make
RUN make install
RUN cd ..

RUN wget "https://www.aquamaniac.de/sites/download/download.php?package=01&release=201&file=01&dummy=gwenhywfar-4.15.3.tar.gz" --output-document=gwenhywfar-4.15.3.tar.gz
RUN tar -xvzf gwenhywfar-4.15.3.tar.gz
RUN cd gwenhywfar-4.15.3
RUN ./configure --with-guis
RUN make
RUN make install
RUN cd ..

RUN wget "https://www.openssl.org/source/openssl-1.0.2k.tar.gz" --output-document=openssl-1.0.2k.tar.gz
RUN tar -xvzf openssl-1.0.2k.tar.gz
RUN cd openssl-1.0.2k
RUN ./config --prefix=/usr/local/openssl --openssldir=/usr/local/openssl
RUN make
RUN make install
RUN cd ..

RUN wget "https://downloads.sourceforge.net/project/openhbci/openhbci2/1.9.4/openhbci2-1.9.4.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fopenhbci%2Ffiles%2F&ts=1486365901&use_mirror=netix" --output-document=openhbci2-1.9.4.tar.gz
RUN tar -xvzf openhbci2-1.9.4.tar.gz
RUN cd openhbci2-1.9.4
RUN ./configure
RUN make
RUN make install
RUN cd ..
