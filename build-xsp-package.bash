#!/bin/bash
set -e

die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "Please specify the version of XSP you want to build as the argument. (Check the tags here: https://github.com/mono/xsp)"

which fpm > /dev/null || die "Please install fpm (from gem, not apt-get)"

which git > /dev/null || die "Please install git"

which mono > /dev/null || die "Please install mono 3.x"

WORK_DIR=/tmp/7digital-xsp-work
rm -rf $WORK_DIR
mkdir $WORK_DIR
cd $WORK_DIR

XSP_VERSION=$1

SEVEND_VERSION="701"
XSP7D_VERSION=$XSP_VERSION'.'$SEVEND_VERSION
XSP7D_NAME="xsp-7d"

echo "Downloading $XSP_VERSION"

git clone https://github.com/mono/xsp.git
XSP_DIR="$WORK_DIR/xsp"
cd "$XSP_DIR"

# TODO: get rid of this if when the tag with this commit is created
if [ "$XSP_VERSION" = "3.0.10" ]
then
	git checkout 4587438369691b9b3e8415e1f113aa98b57d1fde
else
	git checkout $XSP_VERSION
fi

TARGET_DIR="$WORK_DIR/destdir"
mkdir $TARGET_DIR

./autogen.sh --prefix=/usr
make
make install DESTDIR="$TARGET_DIR"
cd $WORK_DIR

fpm -s dir \
    -t deb \
    -n $XSP7D_NAME \
    -v $XSP7D_VERSION \
    -C $TARGET_DIR \
    usr/bin usr/lib usr/share

echo "Done. Your package should be ready in $WORK_DIR"
