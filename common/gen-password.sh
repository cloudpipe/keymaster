#!/bin/sh
#
# Generate a dev password.

generate_password()
{
  info "Generating a random password."

  touch ${PASSFILE}
  chmod 600 ${PASSFILE}

  # "If the same pathname argument is supplied to -passin and -passout arguments then the first
  # line will be used for the input password and the next line for the output password."
  cat /dev/random | head -c 128 | base64 | sed -n '{p;p;}' >> ${PASSFILE}

  info "Random password created."
}

require_password()
{
  [ -f ${PASSFILE} ] || generate_password
}
