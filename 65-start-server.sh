openssl s_server -accept 1234 -cert server-cross-signed/server-cross-signed-CA2.cert.pem -CAfile CA2/certs/ca.cert.pem -key server-cross-signed/private.key.pem -chain
