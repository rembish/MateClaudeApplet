DEB = $(shell dpkg-parsechangelog -SSource)_$(shell dpkg-parsechangelog -SVersion)_all.deb
BUILDINFO = $(shell dpkg-parsechangelog -SSource)_$(shell dpkg-parsechangelog -SVersion)_$(shell dpkg-architecture -qDEB_HOST_ARCH).buildinfo
CHANGES  = $(shell dpkg-parsechangelog -SSource)_$(shell dpkg-parsechangelog -SVersion)_$(shell dpkg-architecture -qDEB_HOST_ARCH).changes

.PHONY: all build clean install uninstall reinstall lint

all: build

build:
	dpkg-buildpackage -us -uc -b

clean:
	dh clean
	rm -f ../$(DEB) ../$(BUILDINFO) ../$(CHANGES)

install: build
	sudo dpkg -i ../$(DEB)

uninstall:
	sudo dpkg -r $(shell dpkg-parsechangelog -SSource)

reinstall: uninstall install

lint: build
	lintian --color auto ../$(DEB)
