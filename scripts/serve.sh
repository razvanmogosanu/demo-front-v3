#!/bin/bash

echo "Creating root server"
openssl genrsa -out root.key 2048
openssl req -x509 -new -nodes -key root.key -sha256 -days 365 -out root.crt

echo "Creating server certificate"
openssl genrsa -out server.key 2048
openssl req -new -key server.key -out server.csr
openssl x509 -req -in server.csr -CA root.crt -CAkey root.key -CAcreateserial -out server.crt -days 365 -sha256


echo "Adding server to root"
#sudo security add-trusted-cert -d -r trustRoot -k "/Library/Keychains/System.keychain" <path_to_certificate_file>

echo "Running server"
node server.js
