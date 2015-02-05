#!/bin/bash
#
# Generate a keypair that's signed by the certificate authority. These should be used for internal
# communications.

# Arguments:
# - NAME
# - PURPOSE, either "server", "client", or "both"
# - LIFETIME in days
# - HOSTNAME
generate_keypair()
{
  require_password
  require_ca_certificate

  local NAME=$1
  local PURPOSE=$2
  local LIFETIME=$3
  local HOSTNAME=$4
  local ALTNAME=$5

  local SERIALOPT="-CAcreateserial"
  [ -f ${CERTDIR}/ca.srl ] && SERIALOPT="-CAserial ${CERTDIR}/ca.srl"

  local EXTFILE="/tmp/ext.cnf"
  local EXTOPT=""
  if [ "${PURPOSE}" = "client" ]; then
      echo "extendedKeyUsage = clientAuth" >> "${EXTFILE}"
      EXTOPT="-extfile ${EXTFILE}"
  elif [ "${PURPOSE}" = "both" ]; then
      echo "extendedKeyUsage = clientAuth,serverAuth" >> "${EXTFILE}"
      EXTOPT="-extfile ${EXTFILE}"
  fi

  if [ ! -z "${ALTNAME}" ]; then
      echo "subjectAltName=${ALTNAME}" >> "${EXTFILE}"
      EXTOPT="-extfile ${EXTFILE}"
  fi

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
  openssl x509 -req -days ${LIFETIME} \
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
