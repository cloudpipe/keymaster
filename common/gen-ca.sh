#!/bin/bash
#
# Generate a CA certificate.

# Arguments:
# - LIFETIME in days
generate_ca_certificate()
{
  require_password

  local LIFETIME=$1

  info "Generating a CA certificate."

  openssl genrsa -des3 \
    -passout ${PASSOPT} \
    -out ${CERTDIR}/ca-key.pem 2048

  openssl req -new -x509 -days "${LIFETIME}" \
    -batch \
    -passin ${PASSOPT} \
    -key ${CERTDIR}/ca-key.pem \
    -passout ${PASSOPT} \
    -out ${CAFILE}

  success "CA certificate generated."
}

require_ca_certificate()
{
  if [ ! -f ${CAFILE} ]; then
    error "Please generate a certificate authority with the 'ca' script first."
    exit 1
  fi
}
