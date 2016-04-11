#!/bin/sh

set -e

if [ -f "./vars" ]; then
 . ./vars
else
  . ../vars
fi

mkdir -p dist

for beat in ${beats}; do
	cd obj
	tar -zcf ../dist/${beat}-${v}.tar.gz ${beat}-${v}
done
