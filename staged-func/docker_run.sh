#!/bin/bash
pushd $(pwd)/../molecule-js-env/ipc-dag-src/tests/ipc/stages/ > /dev/null
echo -e "\033[42;37m Staged Function Tests\033[0m"
echo -e "\033[42;37m (1) Molecule's Results\033[0m"
./run_alexa_stage_tests.sh -a
echo -e "\033[42;37m (2) Baseline's Results\033[0m"
./run_alexa_stage_tests.sh -b
echo -e "\033[42;37m Staged Function Tests Finished\033[0m"
popd > /dev/null
