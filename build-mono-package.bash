#!/bin/bash
set -e

die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "Please specify the version of Mono you want to build as the argument. (Check the versions in the tarball list here: http://download.mono-project.com/sources/mono/)"

which fpm > /dev/null || (echo "Please install fpm (from gem, not apt-get)" && exit 1)

if mono --version > /dev/null 2>&1; then
	echo "Mono is installed locally; please uninstall first" && exit 1
fi

WORK_DIR=/tmp/7digital-mono-work
rm -rf $WORK_DIR
mkdir $WORK_DIR
cd $WORK_DIR

MONO_VERSION=$1
MONO_DIR="mono-$MONO_VERSION"

SEVEND_VERSION="701"
MONO7D_VERSION=$MONO_VERSION'.'$SEVEND_VERSION
MONO7D_NAME="mono-7d"

echo "Downloading $MONO_VERSION"
wget http://download.mono-project.com/sources/mono/mono-$MONO_VERSION.tar.bz2

tar -jxf mono-$MONO_VERSION.tar.bz2
TARGET_DIR="$WORK_DIR/destdir"
mkdir $TARGET_DIR

cd "$WORK_DIR/$MONO_DIR"

./configure --prefix=/usr
make
make install DESTDIR="$TARGET_DIR"
cd $WORK_DIR

fpm -s dir \
    -t deb \
    -n $MONO7D_NAME \
    -v $MONO7D_VERSION \
    -C $TARGET_DIR \
    -d "libglib2.0-dev (>= 0)" \
    usr/bin usr/lib usr/share usr/include usr/etc

echo "Done. Your package should be ready in $WORK_DIR"

