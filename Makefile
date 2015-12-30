VERSION=1.2.1

default : connect-iq_${VERSION}.deb

connect-iq_${VERSION}.deb :
	dpkg -b pkg-debian/ connect-iq_${VERSION}.deb

clean :
	rm -f *.deb
