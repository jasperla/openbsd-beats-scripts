build:
	sh ${.CURDIR}/build.sh

tar:
	sh ${.CURDIR}/tar.sh

upload:
	scp dist/*.tar.gz distfiles.nl:distfiles/beats

all: build tar upload

clean:
	rm -fr obj *.core *~
