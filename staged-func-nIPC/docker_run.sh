#!/bin/bash
pushd $(pwd)/../molecule-js-env/ipc-nIPC-src/tests/ipc/stages/ > /dev/null
./run_alexa_stage_tests.sh -a
popd > /dev/null
