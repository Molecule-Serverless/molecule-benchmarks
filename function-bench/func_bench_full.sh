#!/bin/bash

## Invoke a single test
## Arg1: test-name
## Arg2: test-path
function run_test(){
	echo ""
	echo -e "\tTest-Case: $1"
	./app_template_build.sh ../../functionBench/molecule/python-template > /dev/null 2>&1
	./app_base_build.sh $2 > /dev/null 2>&1
	./app_endpoint_build.sh $2 > /dev/null 2>&1
	./kill_all.sh
	./run_fork.sh > /dev/null 2>&1
	python3 ./test_app.py
	#python3 ./test_app.py baseline
}

echo "Function-bench Tests"

# ./app_base_build.sh ../../functionBench/molecule/matmul
pushd ../../forkable-python-runtime/scripts > /dev/null

run_test LinPack ../../functionBench/molecule/linpack
run_test Chameleon ../../functionBench/molecule/chameleon
run_test Matmul ../../functionBench/molecule/matmul
run_test PyAES ../../functionBench/molecule/pyaes
run_test Video-Processing ../../functionBench/molecule/video_processing
run_test DD ../../functionBench/molecule/dd
run_test Gzip-comprssion ../../functionBench/molecule/gzip_compression

popd
