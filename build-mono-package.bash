#!/bin/bash
set -e

MONO_VERSION=$1

rm -rf mono
rm -rf out

mkdir -p out
git clone -b mono-"$MONO_VERSION" git://github.com/mono/mono.git --depth 1
cd mono

./autogen.sh --prefix=/usr
make
make install DESTDIR="`readlink -f ../out`"

fpm -s dir \
    -t deb \
    -C out \
    --name "mono-7d" \
    --version  "$MONO_VERSION" \
    --iteration "7$BUILD_NUMBER" \
    --depends "libglib2.0-dev (>= 0)" \
    --deb-user root \
    --deb-group root \
    --package mono-7d_VERSION-ITERATION_ARCH.deb usr/bin usr/lib usr/share usr/include usr/etc
