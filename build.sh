#!/bin/sh

set -e

if [ -f "./vars" ]; then
 . ./vars
else
  . ../vars
fi

rm -fr obj && mkdir -p obj

build=$(mktemp -d)

export GOPATH=${build}
export GO15VENDOREXPERIMENT=1

for beat in ${beats}; do
	objdir=obj/${beat}-${v}
	mkdir ${objdir}

	echo "building ${beat} for ${goarch}"
	go get -u ${repo}/${beat}
	$(cd ${build}/src/${repo}/ && git checkout -q v${v})
	
	cp ${build}/bin/${beat} ${objdir}/${beat}-${goarch}
	cp -r ${build}/src/${repo}/${beat}/etc/ ${objdir}
	echo "built ${beat}-${goarch}"
done

rm -fr ${build}
