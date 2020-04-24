#!/bin/sh

set -e

DOCKER=$(which docker)

if [ "${DEBUG}" = 1 ]; then
    echo "${USAGE}"
    exit 1
fi

make

exit 0
