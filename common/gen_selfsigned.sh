#!/bin/bash
#
# Generate an independent, self-signed keypair that isn't related to a certificate authority.

# Arguments:
# - NAME
generate_selfsigned()
{
  local NAME=$1

  info "Generating a self-signed keypair for: <${NAME}>"

  openssl req -x509 -newkey rsa:2048 -days 365 -nodes -batch \
    -keyout /certificates/${NAME}-key.pem \
    -out /certificates/${NAME}-cert.pem

  success "Self-signed keypair generated for: <${NAME}>"
}
