#!/bin/bash

# Going to current script
CURRENT_DIR=$(dirname $0)
cd "$CURRENT_DIR"

git clone https://github.com/sstephenson/bats

export PATH=${CURRENT_DIR}/bats/bin:$PATH

echo $PATH

bats -v
