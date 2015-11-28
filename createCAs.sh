#!/bin/sh
initCAdirs()
{
	umask 077
	CA=$1
	mkdir -p ${CA}
	mkdir -p ${CA}/{certs,crl,newcerts,private}
	echo 1000 > ${CA}/serial
	touch ${CA}/index.txt
}

createCAkey()
{
	CA=$1
	openssl genrsa -aes256 -out ${CA}/private/ca.key.pem 4096
}

createCAcert()
{
	CA=$1
	openssl req -config ${CA}-openssl.cnf \
		-key ${CA}/private/ca.key.pem \
		-new -x509 -days 3650 -sha256 -extensions v3_ca \
		-out ${CA}/certs/ca.cert.pem
}

rm -rf CA1 CA2

initCAdirs "CA1"
createCAkey "CA1"
createCAcert "CA1"


initCAdirs "CA2"
createCAkey "CA2"
createCAcert "CA2"

