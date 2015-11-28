#!/bin/sh
cd server-cross-signed

cat ../CA2/certs/ca.cert.pem server-cross-signed-CA2.cert.pem > combined.cert.pem

echo "verify using CA1"
openssl verify -verbose -CAfile ../CA1/certs/ca.cert.pem combined.cert.pem
echo "verify using CA2"
openssl verify -verbose -CAfile ../CA2/certs/ca.cert.pem combined.cert.pem

cat server-cross-signed-CA2.cert.pem ../CA2/certs/ca.cert.pem > combined.cert.pem

echo "verify using CA1"
openssl verify -verbose -CAfile ../CA1/certs/ca.cert.pem combined.cert.pem
echo "verify using CA2"
openssl verify -verbose -CAfile ../CA2/certs/ca.cert.pem combined.cert.pem




cat ../CA1/certs/ca.cert.pem ../CA2/certs/ca.cert.pem server-cross-signed-CA2.cert.pem > combined.cert.pem

echo "verify using CA1"
openssl verify -verbose -CAfile ../CA1/certs/ca.cert.pem combined.cert.pem
echo "verify using CA2"
openssl verify -verbose -CAfile ../CA2/certs/ca.cert.pem combined.cert.pem

cat server-cross-signed-CA2.cert.pem ../CA2/certs/ca.cert.pem ../CA1/certs/ca.cert.pem > combined.cert.pem

echo "verify using CA1"
openssl verify -verbose -CAfile ../CA1/certs/ca.cert.pem combined.cert.pem
echo "verify using CA2"
openssl verify -verbose -CAfile ../CA2/certs/ca.cert.pem combined.cert.pem
