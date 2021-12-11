#!/bin/bash
pushd $(pwd)/../molecule-js-env/ipc-dag-src/tests/ipc/chain/ > /dev/null
echo -e "\033[42;37m Chained Function Tests\033[0m"
echo -e "\033[42;37m (1) Molecule's Results\033[0m"
./run_chain.sh
echo -e "\033[42;37m (2) Baseline's Results\033[0m"
./run_chain_baseline.sh
echo -e "\033[42;37m Chained Function Tests Finished\033[0m"
popd > /dev/null
