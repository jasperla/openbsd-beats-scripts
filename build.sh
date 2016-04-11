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

srcdir=$PWD

for beat in ${beats}; do
	objdir=obj/${beat}-${v}
	mkdir ${objdir}

	echo "===> Building ${beat} for ${goarch}"

	echo -n "=> Fetching..."
	go get -d ${repo}/${beat}
	echo "done"

	echo -n "=> Switching to ${v}..."
	(cd ${build}/src/${repo}/ && git checkout -q v${v})
	echo "done"
	
	echo -n "=> Building..."
	cd ${build} && go build ${repo}/${beat}
	echo "done"

	cd ${srcdir}
	install -D ${build}/${beat} ${objdir}/${beat}-${goarch}
	cp -r ${build}/src/${repo}/${beat}/etc/ ${objdir}
	echo "built ${beat}-${goarch}"
done

rm -fr ${build}
