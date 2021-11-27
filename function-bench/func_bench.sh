#!/bin/bash

## Invoke a single test
## Arg1: test-name
## Arg2: test-path
function run_test(){
	echo ""
	echo -e "\tTest-Case: $1 (taking from minutes to tens of minutes)"
	./app_template_build_prebuilt.sh ddnirvana/molecule-ae-python-base-image #> /dev/null 2>&1
	./app_base_build_prebuilt.sh ddnirvana/molecule-ae-app-$2-base #> /dev/null 2>&1
	./app_endpoint_build_prebuilt.sh ddnirvana/molecule-ae-app-$2-ep #> /dev/null 2>&1
	./kill_all.sh
	./run_fork.sh > /dev/null 2>&1
	python3 ./test_app.py
	#python3 ./test_app.py baseline
}

function run_test_long(){
	echo ""
	echo -e "\tTest-Case: $1 (taking tens of minutes! please be patient!)"
	./app_template_build_prebuilt.sh ddnirvana/molecule-ae-python-base-image #> /dev/null 2>&1
	./app_base_build_prebuilt.sh ddnirvana/molecule-ae-app-$2-base #> /dev/null 2>&1
	./app_endpoint_build_prebuilt.sh ddnirvana/molecule-ae-app-$2-ep #> /dev/null 2>&1
	./kill_all.sh
	./run_fork.sh > /dev/null 2>&1
	python3 ./test_app_long.py
	#python3 ./test_app.py baseline
}

echo "Function-bench Tests"

# ./app_base_build.sh ../../functionBench/molecule/matmul
pushd ../../forkable-python-runtime/scripts > /dev/null

sudo rm -rf ~/.base/
mkdir -p ~/.base/container0
mkdir -p ~/.base/spin0
mkdir -p ~/.base/baseline

run_test LinPack linpack
run_test Chameleon chameleon
run_test Matmul matmul
run_test PyAES pyaes
run_test DD dd
run_test Gzip-comprssion gzip-compression
run_test_long Video-Processing video-processing

popd
