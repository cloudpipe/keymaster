#!/bin/bash
#
# Variables shared by common/ scripts.

export ROOTDIR=$(cd $(dirname $0)/..; pwd)
export CERTDIR=/certificates

export PASSFILE="${CERTDIR}/dev.password"

export PASSOPT="file:${PASSFILE}"
