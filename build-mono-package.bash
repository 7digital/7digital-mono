#!/bin/bash
set -e

mkdir -p out
git clone -b app-config-fix git://github.com/7digital/mono.git --depth 1
cd mono

./autogen.sh --prefix=/usr
make
make install DESTDIR="`readlink -f ../out`"

fpm -s dir \
    -t deb \
    -C out \
    --name "mono-7d" \
    --version 3.2.6 \
    --iteration "7$BUILD_NUMBER" \
    --depends "libglib2.0-dev (>= 0)" \
    --deb-user root \
    --deb-group root \
    --package mono-7d_VERSION-ITERATION_ARCH.deb usr/bin usr/lib usr/share usr/include usr/etc
