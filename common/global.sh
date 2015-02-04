#!/bin/bash
#
# Variables shared by common/ scripts.

set -o errexit

export ROOTDIR=$(cd $(dirname $0)/..; pwd)
export CONFDIR=${ROOTDIR}/conf
export CERTDIR=/certificates

export PASSFILE="${HOME}/password"
export CAFILE="${CERTDIR}/ca.pem"

export PASSOPT="file:${PASSFILE}"
