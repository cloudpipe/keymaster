#!/bin/bash
#
# Output coloring to make keymaster output show up more prominently among the OpenSSL output.

_color()
{
  local COLOR_CODE=$1
  local SIGIL=$2
  local MESSAGE=$3

  echo -e "\033[${COLOR_CODE}m[${SIGIL}]\033[0m ${MESSAGE}"
}

info()
{
  _color "1;34" ".." "${1}"
}

warning()
{
  _color "1;33" "!!" "${1}"
}

error()
{
  _color "1;31" "!!" "${1}"
}
