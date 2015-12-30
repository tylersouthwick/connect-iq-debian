VERSION=1.2.1

default : connect-iq_${VERSION}.deb

connectiq-sdk-win-${VERSION}.zip :
	curl http://developer.garmin.com/downloads/connect-iq/sdks/connectiq-sdk-win-${VERSION}.zip > connectiq-sdk-win-${VERSION}.zip

target : connectiq-sdk-win-${VERSION}.zip pkg-debian/DEBIAN/control
	mkdir -p target
	rsync -r pkg-debian/ target
	mkdir -p target/usr/share/connectiq
	unzip connectiq-sdk-win-${VERSION}.zip -d target/usr/share/connectiq
	chmod +x target/usr/share/connectiq/bin/monkeyc
	chmod +x target/usr/share/connectiq/bin/monkeydo

connect-iq_${VERSION}.deb : target
	dpkg -b target/ connect-iq_${VERSION}.deb

clean :
	rm -fv *.deb
	rm -rfv target

install : connect-iq_${VERSION}.deb
	sudo dpkg -i connect-iq_${VERSION}.deb
