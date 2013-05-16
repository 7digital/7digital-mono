#!/bin/bash
set -e

die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "Please specify the version of libgdiplus you want to build as the argument. (Check the tags here: http://download.mono-project.com/sources/libgdiplus/)"

apt-get install -y libpng-dev libX11-dev libcairo-dev libjpeg-dev libtiff-dev libgif-dev

WORK_DIR=/tmp/7digital-libgdiplus-work
rm -rf $WORK_DIR
mkdir $WORK_DIR
cd $WORK_DIR

LIB_GDI_PLUS_VERSION=$1

echo "Downloading $LIB_GDI_PLUS_VERSION"
wget "http://download.mono-project.com/sources/libgdiplus/libgdiplus-$LIB_GDI_PLUS_VERSION.tar.bz2"

tar -xvjf 'libgdiplus-$LIB_GDI_PLUS_VERSION.tar.bz2'
cd libgdiplus-$LIB_GDI_PLUS_VERSION 

./configure
make
make install DESTDIR="$TARGET_DIR"
cd $WORK_DIR

echo "Done. Your package should be ready in $WORK_DIR"
