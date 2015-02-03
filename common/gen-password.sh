#!/bin/bash
#
# Generate a doubled password file based on the password found in `${CERTDIR}/password`.

generate_password()
{
  if [ ! -f ${CERTDIR}/password ]; then
    error "Missing password file."

    cat <<EOM
Please supply a "password" file in your certificate directory to use for the generated
credentials. If you don't want to think of one yourself, use the following to create
one securely:

  touch certificates/password
  chmod 600 certificates/password
  cat /dev/random | head -c 128 | base64 > certificates/password

EOM
    exit 1
  fi

  touch ${PASSFILE}
  chmod 600 ${PASSFILE}

  # "If the same pathname argument is supplied to -passin and -passout arguments then the first
  # line will be used for the input password and the next line for the output password."
  cat ${CERTDIR}/password > ${PASSFILE}
  cat ${CERTDIR}/password >> ${PASSFILE}
}

require_password()
{
  [ -f ${PASSFILE} ] || generate_password
}
