#!/bin/sh
signIntermediaryCert()
{
	parentCA=$1
	childCA=$2

	# generate CSR for intermediary cert
	openssl x509 -x509toreq \
		-in ${childCA}/certs/ca.cert.pem \
		-signkey ${childCA}/private/ca.key.pem \
		-out ${childCA}/${childCA}-req-for-${parentCA}.csr.pem

	# sign intermediary cert
	openssl ca -config ${parentCA}-openssl.cnf \
		-days 3650 -extensions v3_ca \
		-keyfile ${parentCA}/private/ca.key.pem \
		-out ${childCA}/certs/ca-intermediary.cert.pem \
		-infiles ${childCA}/${childCA}-req-for-${parentCA}.csr.pem
}

signIntermediaryCert "CA1" "CA2"
