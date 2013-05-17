#!/bin/bash
set -e

die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "Please specify the version of libgdiplus you want to build as the argument. (Check the versions in the tarball list here: http://download.mono-project.com/sources/libgdiplus/)"


WORK_DIR=/tmp/7digital-libgdiplus-work
rm -rf $WORK_DIR
mkdir $WORK_DIR
cd $WORK_DIR

LIB_GDI_PLUS_VERSION=$1
LIB_GDI_PLUS_NAME="libgdiplus-7d"

echo "Downloading $LIB_GDI_PLUS_VERSION"
wget "http://download.mono-project.com/sources/libgdiplus/libgdiplus-$LIB_GDI_PLUS_VERSION.tar.bz2"

tar -xvjf "libgdiplus-$LIB_GDI_PLUS_VERSION.tar.bz2"
cd libgdiplus-$LIB_GDI_PLUS_VERSION 

TARGET_DIR="$WORK_DIR/destdir"
mkdir $TARGET_DIR
./configure --prefix=/usr
make
make install DESTDIR="$TARGET_DIR"
cd $WORK_DIR

echo $TARGET_DIR
echo $LIB_GDI_PLUS_NAME
fpm -d "libpng-dev" \
    -d "libX11-dev" \
    -d "libcairo-dev" \
    -d "libjpeg-dev" \
    -d "libtiff-dev" \
    -d "libgif-dev" \
    -s dir \
    -t deb \
    -n $LIB_GDI_PLUS_NAME \
    -C $TARGET_DIR \
    usr/lib


echo "Done. Your package should be ready in $WORK_DIR"
