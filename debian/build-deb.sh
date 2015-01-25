#!/bin/bash

cd ..
rm *.orig.tar.gz
git pull

VERSION=`head -n 4 CHANGELOG | tail -n 1 | awk '{print $1}' | sed -r 's/^.{1}//'`
BUILD=`cat  ./build | perl -ne 'chomp; print join(".", splice(@{[split/\./,$_]}, 0, -1), map {++$_} pop @{[split/\./,$_]}), "\n";'`
echo $BUILD > build

#CHANGES=`cat CHANGELOG.md | awk -vRS="##" 'NR<=2' ORS="##" | grep -v "##"`
tar -czf  spamassassin-TxRep_$VERSION.orig.tar.gz .

#dch -v $VERSION-1 --package libjs-twitter-bootstrap $CHANGES
dch -v $VERSION-$BUILD --package spamassassin-txrep "Debianized $VERSION"


debuild -i -us -uc -b

cd ..
#~/bin/publish-deb-packages.sh
