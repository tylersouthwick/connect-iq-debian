VERSION=1.2.1

default : connect-iq-sdk-${VERSION}.deb

connectiq-sdk-win-${VERSION}.zip :
	curl http://developer.garmin.com/downloads/connect-iq/sdks/connectiq-sdk-win-${VERSION}.zip > connectiq-sdk-win-${VERSION}.zip

target : connectiq-sdk-win-${VERSION}.zip pkg-debian/DEBIAN/control
	mkdir -p target
	rsync -r pkg-debian/ target
	mkdir -p target/usr/share/connectiq-sdk
	unzip connectiq-sdk-win-${VERSION}.zip -d target/usr/share/connectiq-sdk > /dev/null
	mkdir -p target/usr/bin
	dos2unix target/usr/share/connectiq-sdk/bin/monkeyc
	chmod +x target/usr/share/connectiq-sdk/bin/monkeyc
	dos2unix target/usr/share/connectiq-sdk/bin/monkeydo
	chmod +x target/usr/share/connectiq-sdk/bin/monkeydo
	dos2unix target/usr/share/connectiq-sdk/bin/connectiq
	chmod +x target/usr/share/connectiq-sdk/bin/connectiq
	dos2unix target/usr/share/connectiq-sdk/bin/connectiqpkg
	chmod +x target/usr/share/connectiq-sdk/bin/connectiqpkg

connect-iq-sdk-${VERSION}.deb : target
	dpkg -b target/ connect-iq-sdk-${VERSION}.deb

clean :
	rm -fv *.deb
	rm -rfv target

install : connect-iq-sdk-${VERSION}.deb
	sudo dpkg -i connect-iq-sdk-${VERSION}.deb
