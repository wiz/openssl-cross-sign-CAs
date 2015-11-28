#!/bin/sh
initCAdirs()
{
	umask 077
	CA=$1
	mkdir -p ${CA}
	mkdir -p ${CA}/{certs,crl,newcerts,private}
	echo 1000 > ${CA}/serial
	touch ${CA}/index.txt
	touch ${CA}/index.txt.attr
}

generateCAkey()
{
	CA=$1
	MODLEN=$2
	openssl genrsa -aes256 -out ${CA}/private/ca.key.pem ${MODLEN}
}

selfSignCAcert()
{
	CA=$1
	openssl req -config ${CA}-openssl.cnf \
		-new -x509 -days 3650 -sha256 -extensions v3_ca \
		-key ${CA}/private/ca.key.pem \
		-out ${CA}/certs/ca.cert.pem
}

signIntermediaryCert()
{
	parentCA=$1
	childCA=$2

	# generate CSR for intermediary cert
	openssl req -config ${childCA}-openssl.cnf \
		-new -sha256 \
		-key ${childCA}/private/ca.key.pem \
		-out ${childCA}/${childCA}-req-for-${parentCA}.csr.pem

	# sign intermediary cert
	openssl ca -config ${parentCA}-openssl.cnf \
		-days 3650 -extensions v3_ca \
		-keyfile ${parentCA}/private/ca.key.pem \
		-out ${childCA}/certs/ca.cert.pem \
		-infiles ${childCA}/${childCA}-req-for-${parentCA}.csr.pem

#	openssl req -config ${childCA}-openssl.cnf \
#		-new -x509 -days 3650 -sha256 -extensions v3_ca \
#		-key ${childCA}/private/ca.key.pem \
#		-out ${childCA}/certs/ca.cert.pem
}

rm -rf CA1 CA2

initCAdirs "CA1"
generateCAkey "CA1" 1024
selfSignCAcert "CA1"

initCAdirs "CA2"
generateCAkey "CA2" 4096
signIntermediaryCert "CA1" "CA2"

