#!/bin/bash
#
# Generate a CA certificate.

generate_ca_certificate()
{
  openssl genrsa -des3 \
    -passout ${PASSOPT} \
    -out ${CERTDIR}/ca-key.pem 2048

  openssl req -new -x509 -days 365 \
    -batch \
    -passin ${PASSOPT} \
    -key ${CERTDIR}/ca-key.pem \
    -passout ${PASSOPT} \
    -out ${CERTDIR}/ca.pem
}
