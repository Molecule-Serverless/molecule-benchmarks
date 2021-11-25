#!/bin/bash
pushd $(pwd)/../molecule-js-env/ipc-dag-src/tests/ipc/chain/ > /dev/null
./run_chain.sh
popd > /dev/null
