#!/bin/sh
set -e

FILENAME="boot2docker.iso"
URL="$1"
CHECKSUM="$2"

# If the file exists, check the checksum to see if we have to redownload it.
# Otherwise, just exit 0 because we have it.
if [ -f "${FILENAME}" ]; then
    ACTUAL=$(shasum -a256 $FILENAME | awk '{print $1}')
    if [ "x${ACTUAL}" = "x${CHECKSUM}" ]; then
        echo "Checksums match. Not redownloading."
        exit 0
    fi
fi

echo "Downloading..."
curl -L ${URL} > ${FILENAME}
