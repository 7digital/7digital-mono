#!/bin/bash
set -e

MONO_VERSION=$1

rm -rf mono
rm -rf out

mkdir -p out
git clone git://github.com/mono/mono.git

cd mono
git checkout mono-"$MONO_VERSION"
./autogen.sh --prefix=/usr
make get-monolite-latest
make EXTERNAL_MCS="${PWD}/mcs/class/lib/monolite/gmcs.exe"
make
make install DESTDIR="`readlink -f ../out`"
cd ..

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
