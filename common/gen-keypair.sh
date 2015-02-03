#!/bin/bash
#
# Generate a keypair that's signed by the certificate authority. These should be used for internal
# communications.

# Arguments:
# - NAME
# - PURPOSE, either "server" or "client"
# - HOSTNAME
generate_keypair()
{
  require_password
  require_ca_certificate

  local NAME=$1
  local PURPOSE=$2
  local HOSTNAME=$3

  local SERIALOPT="-CAcreateserial"
  [ -f ${CERTDIR}/ca.srl ] && SERIALOPT="-CAserial ${CERTDIR}/ca.srl"

  local EXTOPT=""
  [ "${PURPOSE}" = "client" ] && EXTOPT="-extfile /certificates/extclient.cnf"

  info "Generating a CA-signed keypair for: <${NAME}>"

  info ".. key"
  openssl genrsa -des3 \
    -passout ${PASSOPT} \
    -out ${CERTDIR}/${NAME}-key.pem 2048

  info ".. request"
  openssl req -subj "/CN=${HOSTNAME}" -new \
    -batch \
    -passin ${PASSOPT} \
    -key ${CERTDIR}/${NAME}-key.pem \
    -passout ${PASSOPT} \
    -out ${CERTDIR}/${NAME}-req.csr

  info ".. certificate"
  openssl x509 -req -days 365 \
    -passin ${PASSOPT} \
    -in ${CERTDIR}/${NAME}-req.csr \
    -CA ${CERTDIR}/ca.pem \
    -CAkey ${CERTDIR}/ca-key.pem \
    ${SERIALOPT} \
    ${EXTOPT} \
    -out ${CERTDIR}/${NAME}-cert.pem

  info ".. removing key password"
  openssl rsa \
    -passin ${PASSOPT} \
    -in ${CERTDIR}/${NAME}-key.pem \
    -out ${CERTDIR}/${NAME}-key.pem

  success "CA-signed keypair generated for: <${NAME}>"
}
