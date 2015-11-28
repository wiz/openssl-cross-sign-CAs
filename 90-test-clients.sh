openssl s_client -connect 127.0.0.1:1234 -CAfile CA2/certs/ca.cert.pem
openssl s_client -connect 127.0.0.1:1234 -CAfile CA1/certs/ca.cert.pem
