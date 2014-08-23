#!/bin/bash

B2D_VERSION="v1.2.0"
TAG=""

while getopts ":s" opt; do
  case $opt in
    s)
		TAG="${B2D_VERSION}"
		;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

. scripts/shell/1-make-custom-iso.sh "$TAG"
. scripts/shell/2-make-box-from-packer.sh
. scripts/shell/3-run-tests.sh
