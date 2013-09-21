#!/bin/bash
set -e

die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "Please specify the version of FSharp you want to build as the argument. (Check the tags here: https://github.com/fsharp/fsharp)"

which fpm > /dev/null || die "Please install fpm (from gem, not apt-get)"

which git > /dev/null || die "Please install git"

which mono > /dev/null || die "Please install mono 3.x"

WORK_DIR=/tmp/7digital-fsharp-work
rm -rf $WORK_DIR
mkdir $WORK_DIR
cd $WORK_DIR

FSHARP_VERSION=$1

SEVEND_VERSION="701"
FSHARP7D_VERSION=$FSHARP_VERSION'.'$SEVEND_VERSION
FSHARP7D_NAME="fsharp-7d"

echo "Downloading $FSHARP_VERSION"

git clone https://github.com/fsharp/fsharp.git
FSHARP_DIR="$WORK_DIR/fsharp"
cd "$FSHARP_DIR"

git checkout $FSHARP_VERSION

TARGET_DIR="$WORK_DIR/destdir"
mkdir $TARGET_DIR

./autogen.sh --prefix=/usr
make
make install DESTDIR="$TARGET_DIR"
cd $WORK_DIR

fpm -s dir \
    -t deb \
    -n $FSHARP7D_NAME \
    -v $FSHARP7D_VERSION \
    -C $TARGET_DIR \
    usr/bin usr/lib

echo "Done. Your package should be ready in $WORK_DIR"

