#!/bin/sh
cd server-cross-signed
cat server-cross-signed-CA2.cert.pem ../CA2/certs/ca-intermediary.cert.pem ../CA1/certs/ca.cert.pem > combined.cert.pem
