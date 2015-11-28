cd server-cross-signed
openssl s_server -accept 1234 -cert combined.cert.pem -CAfile ../CA1/certs/ca.cert.pem -key private.key.pem -chain
